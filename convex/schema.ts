import { defineSchema, defineTable } from "convex/server";
import { v } from "convex/values";

// Data model for Watt. Everything is keyed off the Firebase user id (`uid`,
// which is the `subject` claim of the Firebase ID token) instead of the
// email/uid mix the old Firestore code used.
export default defineSchema({
  users: defineTable({
    uid: v.string(), // Firebase auth uid (identity.subject)
    email: v.string(),
    username: v.string(),
    firstName: v.string(),
    photoStorageId: v.optional(v.id("_storage")), // Convex file storage
    createdAt: v.number(),
  })
    .index("by_uid", ["uid"])
    .index("by_username", ["username"]),

  // Pending friend requests. Rows are deleted once accepted/rejected.
  friendRequests: defineTable({
    fromUid: v.string(),
    fromUsername: v.string(),
    toUid: v.string(),
    toUsername: v.string(),
    status: v.string(), // "pending"
    createdAt: v.number(),
  })
    .index("by_to", ["toUid", "status"])
    .index("by_from", ["fromUid", "status"]),

  // Symmetric friendship rows: one per (owner -> friend) direction.
  friendships: defineTable({
    ownerUid: v.string(),
    friendUid: v.string(),
    friendUsername: v.string(),
    since: v.number(),
  }).index("by_owner", ["ownerUid"]),

  wagers: defineTable({
    creatorUid: v.string(),
    title: v.string(),
    description: v.string(),
    player1: v.string(),
    player2: v.string(),
    stake: v.string(),
    status: v.string(), // active | pending | won | lost
    date: v.string(),
    createdAt: v.number(),
  }).index("by_creator", ["creatorUid"]),
});
