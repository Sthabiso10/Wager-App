import { mutation, query } from "./_generated/server";
import { v } from "convex/values";
import { requireIdentity, userByUid } from "./users";

// Step 1: the client asks for a short-lived upload URL, then PUTs the file bytes
// to it. Convex returns a storageId which you save via `saveProfilePhoto`.
export const generateUploadUrl = mutation({
  args: {},
  handler: async (ctx) => {
    await requireIdentity(ctx);
    return await ctx.storage.generateUploadUrl();
  },
});

// Step 2: attach the uploaded file to the current user's profile.
export const saveProfilePhoto = mutation({
  args: { storageId: v.id("_storage") },
  handler: async (ctx, args) => {
    const identity = await requireIdentity(ctx);
    const me = await userByUid(ctx, identity.subject);
    if (!me) throw new Error("Create your profile first");
    await ctx.db.patch(me._id, { photoStorageId: args.storageId });
  },
});

// Resolve a servable URL for the signed-in user's profile photo (or null).
export const myProfilePhotoUrl = query({
  args: {},
  handler: async (ctx) => {
    const identity = await ctx.auth.getUserIdentity();
    if (!identity) return null;
    const me = await userByUid(ctx, identity.subject);
    if (!me?.photoStorageId) return null;
    return await ctx.storage.getUrl(me.photoStorageId);
  },
});
