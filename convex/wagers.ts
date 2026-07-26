import { mutation, query } from "./_generated/server";
import { v } from "convex/values";
import { requireIdentity } from "./users";

// Live list of the signed-in user's wagers.
export const myWagers = query({
  args: {},
  handler: async (ctx) => {
    const identity = await ctx.auth.getUserIdentity();
    if (!identity) return [];
    return await ctx.db
      .query("wagers")
      .withIndex("by_creator", (q) => q.eq("creatorUid", identity.subject))
      .order("desc")
      .collect();
  },
});

export const createWager = mutation({
  args: {
    title: v.string(),
    description: v.string(),
    player1: v.string(),
    player2: v.string(),
    stake: v.string(),
    status: v.string(),
    date: v.string(),
  },
  handler: async (ctx, args) => {
    const identity = await requireIdentity(ctx);
    return await ctx.db.insert("wagers", {
      creatorUid: identity.subject,
      ...args,
      createdAt: Date.now(),
    });
  },
});

export const updateStatus = mutation({
  args: { wagerId: v.id("wagers"), status: v.string() },
  handler: async (ctx, args) => {
    const identity = await requireIdentity(ctx);
    const wager = await ctx.db.get(args.wagerId);
    if (!wager || wager.creatorUid !== identity.subject) {
      throw new Error("Wager not found");
    }
    await ctx.db.patch(args.wagerId, { status: args.status });
  },
});

export const deleteWager = mutation({
  args: { wagerId: v.id("wagers") },
  handler: async (ctx, args) => {
    const identity = await requireIdentity(ctx);
    const wager = await ctx.db.get(args.wagerId);
    if (!wager || wager.creatorUid !== identity.subject) {
      throw new Error("Wager not found");
    }
    await ctx.db.delete(args.wagerId);
  },
});
