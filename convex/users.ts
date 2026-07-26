import { mutation, query, QueryCtx, MutationCtx } from "./_generated/server";
import { v } from "convex/values";

// Reads the Firebase identity attached to the request. Throws if the caller is
// not authenticated (the client must call setAuthWithRefresh first).
export async function requireIdentity(ctx: QueryCtx | MutationCtx) {
  const identity = await ctx.auth.getUserIdentity();
  if (!identity) throw new Error("Not authenticated");
  return identity; // identity.subject = Firebase uid, identity.email = email
}

export async function userByUid(ctx: QueryCtx | MutationCtx, uid: string) {
  return await ctx.db
    .query("users")
    .withIndex("by_uid", (q) => q.eq("uid", uid))
    .unique();
}

// Called once after Firebase registration to create the user's profile.
export const createProfile = mutation({
  args: { username: v.string(), firstName: v.string() },
  handler: async (ctx, args) => {
    const identity = await requireIdentity(ctx);
    const existing = await userByUid(ctx, identity.subject);
    if (existing) return existing._id;

    return await ctx.db.insert("users", {
      uid: identity.subject,
      email: identity.email ?? "",
      username: args.username,
      firstName: args.firstName,
      createdAt: Date.now(),
    });
  },
});

// The signed-in user's profile (null if not created yet).
export const currentUser = query({
  args: {},
  handler: async (ctx) => {
    const identity = await ctx.auth.getUserIdentity();
    if (!identity) return null;
    return await userByUid(ctx, identity.subject);
  },
});

export const getByUsername = query({
  args: { username: v.string() },
  handler: async (ctx, args) => {
    return await ctx.db
      .query("users")
      .withIndex("by_username", (q) => q.eq("username", args.username))
      .unique();
  },
});
