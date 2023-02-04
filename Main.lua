local isc = require("TombStone.lib.isaacscript-common")

local CollectibleTypeCustom = {
    TOMBSTONE = Isaac.GetItemIdByName("TombStone")
}

local RevivalType = {
    TOMBSTONE = 0 --was 0
}

--local tombstoneDamage = 0.1

--Sets mod to mod name, 1 is used for the API version, which will always be 1
local modVanilla = RegisterMod("TombStone", 1)
local mod = isc:upgradeMod(modVanilla)

--happens before reviving
local function preCustomRevive(_, player)
  local hasTombstone = player:HasCollectible(CollectibleTypeCustom.TOMBSTONE)
  if hasTombstone then
    return RevivalType.TOMBSTONE
  end
  return nil
end

--Happens after reviving
local function postCustomRevive(_, player)
    player:AnimateCollectible(CollectibleTypeCustom.TOMBSTONE)
    player:ChangePlayerType(isc.PlayerType.Magdalene)
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

