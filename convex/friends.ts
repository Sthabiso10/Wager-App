import { mutation, query } from "./_generated/server";
import { v } from "convex/values";
import { requireIdentity, userByUid } from "./users";

// Send a friend request to someone by their username.
export const sendRequest = mutation({
  args: { toUsername: v.string() },
  handler: async (ctx, args) => {
    const identity = await requireIdentity(ctx);
    const me = await userByUid(ctx, identity.subject);
    if (!me) throw new Error("Create your profile first");

    if (args.toUsername === me.username) {
      throw new Error("You cannot add yourself");
    }

    const target = await ctx.db
      .query("users")
      .withIndex("by_username", (q) => q.eq("username", args.toUsername))
      .unique();
    if (!target) throw new Error("User not found");

    // Already friends?
    const existingFriend = await ctx.db
      .query("friendships")
      .withIndex("by_owner", (q) => q.eq("ownerUid", me.uid))
      .filter((q) => q.eq(q.field("friendUid"), target.uid))
      .first();
    if (existingFriend) throw new Error("You are already friends");

    // Duplicate pending request?
    const existingRequest = await ctx.db
      .query("friendRequests")
      .withIndex("by_to", (q) => q.eq("toUid", target.uid).eq("status", "pending"))
      .filter((q) => q.eq(q.field("fromUid"), me.uid))
      .first();
    if (existingRequest) throw new Error("Friend request already pending");

    await ctx.db.insert("friendRequests", {
      fromUid: me.uid,
      fromUsername: me.username,
      toUid: target.uid,
      toUsername: target.username,
      status: "pending",
      createdAt: Date.now(),
    });
  },
});

// Live list of pending friend requests addressed to the signed-in user.
export const myRequests = query({
  args: {},
  handler: async (ctx) => {
    const identity = await ctx.auth.getUserIdentity();
    if (!identity) return [];
    return await ctx.db
      .query("friendRequests")
      .withIndex("by_to", (q) =>
        q.eq("toUid", identity.subject).eq("status", "pending"),
      )
      .collect();
  },
});

// Accept or reject a request. On accept, two friendship rows are created.
export const respondToRequest = mutation({
  args: { requestId: v.id("friendRequests"), action: v.string() },
  handler: async (ctx, args) => {
    const identity = await requireIdentity(ctx);
    const request = await ctx.db.get(args.requestId);
    if (!request || request.toUid !== identity.subject) {
      throw new Error("Request not found");
    }

    if (args.action === "accept") {
      const now = Date.now();
      await ctx.db.insert("friendships", {
        ownerUid: request.toUid,
        friendUid: request.fromUid,
        friendUsername: request.fromUsername,
        since: now,
      });
      await ctx.db.insert("friendships", {
        ownerUid: request.fromUid,
        friendUid: request.toUid,
        friendUsername: request.toUsername,
        since: now,
      });
    }

    await ctx.db.delete(args.requestId);
  },
});

// Live list of the signed-in user's friends.
export const myFriends = query({
  args: {},
  handler: async (ctx) => {
    const identity = await ctx.auth.getUserIdentity();
    if (!identity) return [];
    return await ctx.db
      .query("friendships")
      .withIndex("by_owner", (q) => q.eq("ownerUid", identity.subject))
      .collect();
  },
});
