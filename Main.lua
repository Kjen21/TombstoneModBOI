local isc = require("tombstone.lib.isaacscript-common")

local CollectibleTypeCustom = {
    TOMBSTONE = Isaac.GetItemIdByName("Tombstone"),
}

local RevivalType = {
    TOMBSTONE = 0,
}

local modVanilla = RegisterMod("TombStone", 1)
local mod = isc:upgradeMod(modVanilla)

local function preCustomRevive(_, player)
  local hasTombstone = player:HasCollectible(CollectibleTypeCustom.TOMBSTONE)
  if hasTombstone then
    return RevivalType.TOMBSTONE
  end
  return nil;
end

local function postCustomRevive(_, player)
    player:AnimateCollectible(CollectibleTypeCustom.TOMBSTONE)
    player:ChangePlayerType(isc.PlayerType.MAGDALENE)
    player:RemoveCollectible(CollectibleTypeCustom.TOMBSTONE)
  end

mod:AddCallbackCustom(isc.ModCallbackCustom.PRE_CUSTOM_REVIVE, preCustomRevive)
mod:AddCallbackCustom(isc.ModCallbackCustom.POST_CUSTOM_REVIVE, postCustomRevive, RevivalType.TOMBSTONE)

--Temp disabled to try new code
--callback is a function in BOI that takes place when something happens in the game (related to your item)
-- local tombstoneCallbacks = {}
-- mod.AddCallback(tombstoneCallbacks);

-- function mod:EvaluateCache(player, cacheFlags)
--     if cacheFlags & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
--         --calculates the dmg equal to the number of collectibles of this type
--         local itemCount = player:GetCollectibleNum(CollectibleTypeCustom.tombstone)
--         local damageToAdd = 1 + (tombstoneDamage * itemCount)


--         player.Damage = player.Damage * damageToAdd
--     end
-- end

-- mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.EvaluateCache)

