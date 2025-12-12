#include maps\mp\zombies\_wall_buys;

main()
{
    setdvar("g_useholdtime", 0); 
    common_scripts\utility::create_dvar("fb", "crossbow monkey mahem");
}

init()
{
    level.originalMagicboxWeapons = [];
    level thread storeMagicboxWeapons();

    level thread initWeaponDatabase();
    level thread firstbox();
}

storeMagicboxWeapons()
{
    wait 0.5;
    
    for(i = 0; i < level.magicboxweapons.size; i++)
    {
        level.originalMagicboxWeapons[i] = level.magicboxweapons[i];
    }
}

initWeaponDatabase()
{
    level.weaponData = [];
    level.weaponData["rw1"] = ["iw5_rw1zm", "npc_rw1_main_base_static_holo", &"ZOMBIES_RW1", "none", "none", "none", undefined];
    level.weaponData["vbr"] = ["iw5_vbrzm", "npc_vbr_base_static_holo", &"ZOMBIES_VBR", "none", "none", "none", undefined];
    level.weaponData["gm6"] = ["iw5_gm6zm", "npc_gm6_base_static_holo", &"ZOMBIES_GM6", "gm6scope", "none", "none", undefined];
    level.weaponData["lsat"] = ["iw5_lsatzm", "npc_lsat_base_static_holo", &"ZOMBIES_LSAT", "none", "none", "none", undefined];
    level.weaponData["asaw"] = ["iw5_asawzm", "npc_ameli_base_static_holo", &"ZOMBIES_ASAW", "none", "none", "none", undefined];
    level.weaponData["ak12"] = ["iw5_ak12zm", "npc_ak12_base_static_holo", &"ZOMBIES_AK12", "none", "none", "none", undefined];
    level.weaponData["bal27"] = ["iw5_bal27zm", "npc_bal27_base_black_static_holo", &"ZOMBIES_BAL27", "none", "none", "none", undefined];
    level.weaponData["himar"] = ["iw5_himarzm", "npc_himar_base_static_holo", &"ZOMBIES_IMR", "none", "none", "none", undefined];
    level.weaponData["asm1"] = ["iw5_asm1zm", "npc_asm1_base_static_holo", &"ZOMBIES_ASM1", "none", "none", "none", undefined];
    level.weaponData["sn6"] = ["iw5_sn6zm", "npc_sn6_base_black_static_holo", &"ZOMBIES_SN6", "none", "none", "none", undefined];
    level.weaponData["sac3"] = ["iw5_sac3zm", "npc_sac3_base_static_holo", &"ZOMBIES_SAC3", "none", "none", "none", undefined];
    level.weaponData["em1"] = ["iw5_em1zm", "npc_em1_base_static_holo", &"ZOMBIES_EM1", "none", "none", "none", undefined];
    level.weaponData["ae4"] = ["iw5_dlcgun1zm","npc_dear_base_static_holo", &"ZOMBIES_DLC_GUN_1", "none", "none", "none", undefined];
    level.weaponData["ohm"] = ["iw5_dlcgun2zm", "npc_lmg_shotgun_base_static_holo", &"ZOMBIE_WEAPONDLC2_GUN", "none", "none", "none", undefined];
    level.weaponData["m1"] = ["iw5_dlcgun3zm", "npc_m1_irons_base_static_holo", &"ZOMBIE_WEAPONDLC3_GUN", "none", "none", "none", undefined];
    level.weaponData["s12"] = ["iw5_rhinozm", "npc_rhino_base_static_holo", &"ZOMBIES_RHINO", "none", "none", "none", undefined];
    level.weaponData["cel13"] = ["iw5_fusionzm", "npc_fusion_shotgun_base_holo", &"ZOMBIES_FUSION_RIFLE", "none", "none", "none", 2];
    level.weaponData["crossbow"] = ["iw5_exocrossbowzm", "npc_crossbow_base_static_holo", &"ZOMBIES_CROSSBOW", "none", "none", "none", undefined];
    level.weaponData["mahem"] = ["iw5_mahemzm", "npc_mahem_base_holo", &"ZOMBIES_MAHEM", "none", "none", "none", undefined];
    level.weaponData["magnetron"] = ["iw5_microwavezm", "dlc_npc_microwave_gun_holo", &"ZOMBIES_MWG", "none", "none", "none", 1];
    level.weaponData["limbo"] = ["iw5_linegunzm", "npc_zom_line_gun_holo", &"ZOMBIE_WEAPON_LINEGUN_PICKUP", "none", "none", "none", 2];
    level.weaponData["trident"] = ["iw5_tridentzm", "npc_zom_trident_base_holo", &"ZOMBIE_WEAPON_TRIDENT_PICKUP", "none", "none", "none", 2];
    level.weaponData["blunderbuss"] = ["iw5_dlcgun4zm", "npc_blunderbuss_base_holo", &"ZOMBIE_WEAPONDLC4_GUN", "none", "none", "none", 2];
    level.weaponData["monkey"] = ["distraction_drone_zombie", "dlc_distraction_drone_01_holo", &"ZOMBIES_DISTRACTION_DRONE", "none", "none", "none", 2];
    level.weaponData["nano"] = ["dna_aoe_grenade_zombie", "npc_exo_launcher_grenade_holo", &"ZOMBIES_DNA_AOE", "none", "none", "none", 2];
    level.weaponData["repulsor"] = ["repulsor_zombie", "dlc3_repulsor_device_01_holo", &"ZOMBIE_DLC3_REPULSOR", "none", "none", "none", 2];
}

firstbox()
{
    level waittill("zombie_wave_started");
    level endon("game_ended");
    iPrintLn("^:F^7irstbox Patch");

    level.magicboxweapons = [];

    fb_dvar = getDvar("fb");
    weapons = strtok(fb_dvar, " ");
    
    if (weapons.size < 3) 
    {
       iPrintLn("Firstbox disabled. Atleast 3 weapons needed");
       thread resetMagicbox();
    }
    
    for (i = 0; i < weapons.size; i++)
    {
        addWeaponFromDvar(weapons[i], 2);
    }
    
    level thread checkRound();
}

checkRound()
{
    level endon("game_ended");
    
    while (true)
    {
        round = level.wavecounter;
        level waittill("zombie_wave_ended");

        if (round >= 20)   
        {
            resetMagicbox();
            break;
        }
    }
}

resetMagicbox()
{
    level.magicboxweapons = [];
    
    for(i = 0; i < level.originalMagicboxWeapons.size; i++)
    {
        weapon = level.originalMagicboxWeapons[i];
        maps\mp\zombies\_wall_buys::addmagicboxweapon(
            weapon["baseNameNoMP"],
            weapon["displayModel"],
            weapon["displayString"],
            weapon["attachment1"],
            weapon["attachment2"],
            weapon["attachment3"],
            weapon["limit"]
        );
    }
    
    iPrintLn("^:F^7irstbox off");
}

addWeaponFromDvar(weaponName)
{

    if (isDefined(level.weaponData[weaponName])) 
    {
        weapon = level.weaponData[weaponName];


    switch(weapon[0])
    {
    case "distraction_drone_zombie":
        if(level.player getTacticalWeapon() == "distraction_drone_zombie" && (level.player hasWeapon("distraction_drone_zombie") ) )
        {
            return;
        }
        break;

    case "dna_aoe_grenade_zombie":
        if(level.player getTacticalWeapon() == "dna_aoe_grenade_zombie" && (level.player hasWeapon("dna_aoe_grenade_zombie") ) )
        {
            return;
        }
        break;

    case "repulsor_zombie":
        if(level.player getTacticalWeapon() == "repulsor_zombie" && (level.player hasWeapon("repulsor_zombie") ) )
        {
            return;
        }
        break;
    }

    maps\mp\zombies\_wall_buys::addmagicboxweapon(weapon[0], weapon[1], weapon[2], weapon[3], weapon[4], weapon[5]);
        } 
        
        else {
                iPrintLn("Error: Unknown weapon '" + weaponName + "'");
        }
}

