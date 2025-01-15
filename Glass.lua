--- STEAMODDED HEADER
--- MOD_NAME: Glass
--- MOD_ID: Glass
--- PREFIX: gls
--- MOD_AUTHOR: [@your_fetish]
--- MOD_DESCRIPTION: My vision of better Glass Cards with a new Glass Deck and bug fixes with Glass Joker.
--- VERSION: 1.0.0
----------------------------------------------
------------MOD CODE -------------------------

SMODS.Back {
    key = 'glass_deck',
    name = "Glass Deck",
    stake = 1,
    unlocked = true,
    order = 20,
    pos = { x = 5, y = 1 },
    set = "Back",
    config = {
        jokers = {
            { id = 'j_oops', eternal = true, edition = 'negative' },
            { id = 'j_oops', eternal = true, edition = 'negative' },
            -- { id = 'j_vampire', },
            -- { id = 'j_midas_mask', },
            -- { id = 'j_certificate', },
            -- { id = 'j_marble', },
            -- { id = 'j_glass', },
        },
        -- vouchers = { 'v_magic_trick', 'v_illusion' },
        -- consumables = { 'c_aura', 'c_aura', 'c_aura', 'c_aura', 'c_ectoplasm', 'c_ectoplasm', 'c_hanged_man', 'c_immolate', 'c_grim', 'c_incantation' },
    },
    discovered = true,
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    v:set_ability(G.P_CENTERS.m_glass)
                end
                return true
            end
        }))
    end
}

local function random_destroy(used_tarot)
    local destroyed_cards = {}
    destroyed_cards[#destroyed_cards + 1] = pseudorandom_element(G.hand.cards, pseudoseed('random_destroy'))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
            play_sound('tarot1')
            used_tarot:juice_up(0.3, 0.5)
            return true
        end
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
            for i = #destroyed_cards, 1, -1 do
                local card = destroyed_cards[i]
                if card.ability.name == 'Glass Card' then
                    card:shatter()
                else
                    card:start_dissolve(nil, i ~= #destroyed_cards)
                end
            end
            return true
        end
    }))
    return destroyed_cards
end

SMODS.Consumable:take_ownership('familiar', {
    use = function(self, card, area, copier)
        local used_tarot = copier or card
        local destroyed_cards = random_destroy(used_tarot)
        for k, v in ipairs(destroyed_cards) do
            if SMODS.has_enhancement(v, 'm_glass') then
                v.shattered = true
            end
        end

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.7,
            func = function()
                local cards = {}
                for i = 1, card.ability.extra do
                    cards[i] = true
                    -- TODO preserve suit vanilla RNG
                    local faces = {}
                    for _, v in ipairs(SMODS.Rank.obj_buffer) do
                        local r = SMODS.Ranks[v]
                        if r.face then table.insert(faces, r) end
                    end
                    local _suit, _rank =
                        pseudorandom_element(SMODS.Suits, pseudoseed('familiar_create')).card_key,
                        pseudorandom_element(faces, pseudoseed('familiar_create')).card_key
                    local cen_pool = {}
                    for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                        if v.key ~= 'm_stone' and not v.overrides_base_rank then
                            cen_pool[#cen_pool + 1] = v
                        end
                    end
                    local center = pseudorandom_element(cen_pool, pseudoseed('spe_card'))
                    if G.GAME.selected_back.name == 'Glass Deck' then
                        center = G.P_CENTERS.m_glass
                    end
                    create_playing_card({
                        front = G.P_CARDS[_suit .. '_' .. _rank],
                        center = center
                    }, G.hand, nil, i ~= 1, { G.C.SECONDARY_SET.Spectral })
                end
                playing_card_joker_effects(cards)
                return true
            end
        }))
        delay(0.3)
        SMODS.calculate_context({ remove_playing_cards = true, removed = destroyed_cards })
    end,
})

SMODS.Consumable:take_ownership('grim', {
    use = function(self, card, area, copier)
        local used_tarot = copier or card
        local destroyed_cards = random_destroy(used_tarot)
        for k, v in ipairs(destroyed_cards) do
            if SMODS.has_enhancement(v, 'm_glass') then
                v.shattered = true
            end
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.7,
            func = function()
                local cards = {}
                for i = 1, card.ability.extra do
                    cards[i] = true
                    -- TODO preserve suit vanilla RNG
                    local _suit, _rank =
                        pseudorandom_element(SMODS.Suits, pseudoseed('grim_create')).card_key, 'A'
                    local cen_pool = {}
                    for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                        if v.key ~= 'm_stone' and not v.overrides_base_rank then
                            cen_pool[#cen_pool + 1] = v
                        end
                    end
                    local center = pseudorandom_element(cen_pool, pseudoseed('spe_card'))
                    if G.GAME.selected_back.name == 'Glass Deck' then
                        center = G.P_CENTERS.m_glass
                    end
                    create_playing_card({
                        front = G.P_CARDS[_suit .. '_' .. _rank],
                        center = center
                    }, G.hand, nil, i ~= 1, { G.C.SECONDARY_SET.Spectral })
                end
                playing_card_joker_effects(cards)
                return true
            end
        }))
        delay(0.3)
        SMODS.calculate_context({ remove_playing_cards = true, removed = destroyed_cards })
    end,
})

SMODS.Consumable:take_ownership('incantation', {
    use = function(self, card, area, copier)
        local used_tarot = copier or card
        local destroyed_cards = random_destroy(used_tarot)
        for k, v in ipairs(destroyed_cards) do
            if SMODS.has_enhancement(v, 'm_glass') then
                v.shattered = true
            end
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.7,
            func = function()
                local cards = {}
                for i = 1, card.ability.extra do
                    cards[i] = true
                    -- TODO preserve suit vanilla RNG
                    local numbers = {}
                    for _, v in ipairs(SMODS.Rank.obj_buffer) do
                        local r = SMODS.Ranks[v]
                        if v ~= 'Ace' and not r.face then table.insert(numbers, r) end
                    end
                    local _suit, _rank =
                        pseudorandom_element(SMODS.Suits, pseudoseed('incantation_create')).card_key,
                        pseudorandom_element(numbers, pseudoseed('incantation_create')).card_key
                    local cen_pool = {}
                    for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                        if v.key ~= 'm_stone' and not v.overrides_base_rank then
                            cen_pool[#cen_pool + 1] = v
                        end
                    end
                    local center = pseudorandom_element(cen_pool, pseudoseed('spe_card'))
                    if G.GAME.selected_back.name == 'Glass Deck' then
                        center = G.P_CENTERS.m_glass
                    end
                    create_playing_card({
                        front = G.P_CARDS[_suit .. '_' .. _rank],
                        center = center
                    }, G.hand, nil, i ~= 1, { G.C.SECONDARY_SET.Spectral })
                end
                playing_card_joker_effects(cards)
                return true
            end
        }))
        delay(0.3)
        SMODS.calculate_context({ remove_playing_cards = true, removed = destroyed_cards })
    end,
})

----------------------------------------------
------------MOD CODE END----------------------
