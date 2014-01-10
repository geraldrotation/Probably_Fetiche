ProbablyEngine.rotation.register_custom(258, "Fétiche Priest", {
	-- In-combat buffing. Just in case we die.
	{"588", {"player.spell(588).exists","!player.buff(588)"}, "player"},
	{"21562", {"player.spell(21562).exists","@fetiche.checkRaidBuff(2)"}, "player"},
	{"15473", {"player.spell(15473).exists","!player.buff(15473)"}, "player"},
	
	-- Body and Soul; Activate on movement when talented
	{"17", {"player.moving","player.spell(64129).exists"}, "player"},
	
	-- Defensive Abilities, just for when things go Oh-shit!
	{"#5512", "player.health <= 40", "player"},
	{"15286", {"player.health <= 40","player.shadoworbs = 3","player.spell(15286).cooldown = 0","@fetiche.clip(Embrace)"}, "player"},
	{"586", {"player.threat >= 95","player.spell(586).cooldown = 0","@fetiche.clip(Fade)"}, "player"},
	--{"19236", {"player.health <= 40","player.spell(19236).cooldown = 0","@fetiche.clip(DPrayer)"}, "player"},
	{"47585", {"modifier.rshift","player.spell(47585).cooldown = 0","@fetiche.clip(Disp)"}, "player"},
	{"32375", {"modifier.ralt","player.spell(32375).cooldown = 0","@fetiche.clip(MDisp)"}, "ground"},
	
	-- Available Cooldowns
	{{
		{"34433", "@fetiche.clip(34433)", "target"},
		{"121279", {"player.spell(121279).exists","@fetiche.clip(121279)"}, "player"},
		{"26297", {"player.spell(26297).exists","@fetiche.clip(26297)"}, "player"},
		{"10060", {"player.spell(10060).exists","@fetiche.clip(10060)"}, "player"},
		{"#gloves"}
	}, {"modifier.cooldowns"}},
	
	-- Shadow AoE; Mind Sear it.
	{"48045", {"modifier.lshift","@fetiche.clip(MSear)"}, "target"},
	
	-- Automated Level 90 Talent abilities can be...bad.. Toggle it!
	{"120644", {
		"modifier.lalt",
		"player.spell(120517).exists",
		"@fetiche.clip(Halo)"
	}},
	{"121135", {
		"modifier.lalt",
		"player.spell(121135).exists",
		"@fetiche.clip(Cascade)"
	}},
	{"110744", {
		"modifier.lalt",
		"player.spell(110744).exists",
		"@fetiche.clip(Star)"
	}},
	
	-- Shadow Priest Standard Rotation
	-- Should we..? Yes we should..
	{{
		{"32379", {"target.health <= 20","!modifier.last(32379)","@fetiche.clip(SWD)"}, "target"},
		
		-- Only invoke when we're starting with Orbs
		{"589", {"!target.debuff(589)","player.shadoworbs = 3","@fetiche.clip(589)"}, "target"},
		{"34914", {"!player.moving","!modifier.last(34914)","!target.debuff(34914)","player.shadoworbs = 3","@fetiche.interrupts('target')","@fetiche.clip(34914)"}, "target"},
		
		{"2944", {"player.shadoworbs = 3","@fetiche.calculateDot('target', DP)","@fetiche.clip(DP)"}, "target"},
		{"8092", {"!player.moving","@fetiche.interrupts('target')","@fetiche.clip(MB)"}, "target"},
		{"8092", {"player.buff(124430)","@fetiche.interrupts('target')","@fetiche.clip(MB)"}, "target"},
		{"32379", {
			"target.health <= 20",
			"!modifier.last(32379)",
			(function()
				if IsPlayerSpell(139139) then
					if UnitDebuffID("target",PD,"PLAYER") then return false else return true end
				else return true end end),
			"@fetiche.clip(SWD)"
		}, "target"},
		{"15407", {"!player.moving","target.debuff(2944)","player.spell(139139).exists","@fetiche.interrupts('target')","@fetiche.clip(MF)"}, "target"},
		
		-- Boss Dotting
		{{
			{"34914", {"!player.moving","!modifier.last(34914)","@fetiche.interrupts('Boss1')","@fetiche.calculateDot('Boss1',34914)","@fetiche.clip(34914,'Boss1')","spell(34914).range"},"Boss1"},
			{"34914", {"!player.moving","!modifier.last(34914)","@fetiche.interrupts('Boss2')","@fetiche.calculateDot('Boss2',34914)","@fetiche.clip(34914,'Boss2')","spell(34914).range"},"Boss2"},
			{"34914", {"!player.moving","!modifier.last(34914)","@fetiche.interrupts('Boss3')","@fetiche.calculateDot('Boss3',34914)","@fetiche.clip(34914,'Boss3')","spell(34914).range"},"Boss3"},
			{"34914", {"!player.moving","!modifier.last(34914)","@fetiche.interrupts('Boss4')","@fetiche.calculateDot('Boss4',34914)","@fetiche.clip(34914,'Boss4')","spell(34914).range"},"Boss4"},
			{"589", {"player.spell(589).exists","@fetiche.calculateDot('Boss1',589)","@fetiche.clip(589,'Boss1')","spell(589).range"},"Boss1"},
			{"589", {"player.spell(589).exists","@fetiche.calculateDot('Boss2',589)","@fetiche.clip(589,'Boss2')","spell(589).range"},"Boss2"},
			{"589", {"player.spell(589).exists","@fetiche.calculateDot('Boss3',589)","@fetiche.clip(589,'Boss3')","spell(589).range"},"Boss3"},
			{"589", {"player.spell(589).exists","@fetiche.calculateDot('Boss4',589)","@fetiche.clip(589,'Boss4')","spell(589).range"},"Boss4"},
		}, "toggle.bossDotting"},
		
		-- Dotting
		{"589", {"@fetiche.calculateDot('target',589)","@fetiche.clip(589)"}, "target"},
		{"34914", {"!player.moving","!modifier.last(34914)","@fetiche.calculateDot('target',34914)","@fetiche.interrupts('target')","@fetiche.clip(34914)"}, "target"},
		
		-- Multidotting
		{{
			{"34914", {"!player.moving","!modifier.last(34914)","@fetiche.interrupts('focus')","@fetiche.calculateDot('focus',34914)","@fetiche.clip(34914,'focus')"},"focus"},
			{"34914", {"!player.moving","!modifier.last(34914)","@fetiche.interrupts('mouseover')","@fetiche.calculateDot('mouseover',34914)","@fetiche.clip(34914,'mouseover')"},"mouseover"},
			{"589", {"player.spell(589).exists","@fetiche.calculateDot('focus',589)","@fetiche.clip(589,'focus')"},"focus"},
			{"589", {"player.spell(589).exists","@fetiche.calculateDot('mouseover',589)","@fetiche.clip(589,'mouseover')"},"mouseover"},
		}, "modifier.multitarget"},
		
		{"73510", {"player.spell(109186).exists","player.buff(87160).count = 2","@fetiche.clip(MS)"}, "target"},
		{"73510", {"player.spell(109186).exists","player.buff(87160).count = 1","@fetiche.clip(MS)"}, "target"},
		{"15407", {"@fetiche.interrupts('target')","@fetiche.clip(MF)"}, "target"}		
	}, {"player.buff(15473)", "@fetiche.immunities('target')"}}
}, {
	-- Out of Combat buffing
	{"588", {"player.spell(588).exists", "!player.buff(588)"}, "player"},
	{"21562", {"player.spell(21562).exists", "@fetiche.checkRaidBuff(2)"}, "player"},
	{"15473", {"player.spell(15473).exists", "!player.buff(15473)"}, "player"}
}, function()
	-- Boss Dotting
	ProbablyEngine.toggle.create(
		'bossDotting',
		'Interface\\ICONS\\inv_jewelry_orgrimmarraid_trinket_13',
		'Boss-dotting',
	"Enable/Disable automatic dotting\n of all boss units in range!")
end)