local function ReplaceIsAlly(self)
    local IsAlly_original = self.IsAlly

    function self:IsAlly(guy, ...)
        -- Only handle ThePlayer and ignore other players on non-dedicated,
        -- non-cave servers
        if self.inst == GLOBAL.ThePlayer then
            -- Ignore options when the creature is attacking
            -- TODO: Check if target is a (=any) player? On PVE servers only?
            --       I think that should be a separate option from IF_HOSTILE.
            --       Might be handy for otherwise unhandled creatures, too.
            --       But: A general 'return false if attacking player' is a
            --       bad idea, as e.g. shadow creatures and mooselings 'target'
            --       players.
            if guy.replica == nil or
               guy.replica.combat == nil or
               guy.replica.combat:GetTarget() ~= self.inst then

                if guy:HasTag("beefalo") then
                    local hasowner = guy.replica.follower:GetLeader() or nil
                    if (hasowner ~= nil) then
                        return true
                    end
                end	
        
                --must use force attack on players' followers
                local follower = guy.replica.follower
                if follower ~= nil then
                    local leader = follower:GetLeader()
                    if leader ~= nil and
                        leader:HasTag("player") and
                        leader.replica.combat:GetTarget() ~= inst then
                        return false
                    end
                end
            end

        end

        return IsAlly_original(self, guy, ...)
    end
end

AddClassPostConstruct("components/combat_replica", ReplaceIsAlly)
