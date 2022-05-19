pico-8 cartridge // http://www.pico-8.com
version 33
__lua__
--components

function cmp_init()
 local c = {
  anim   = {},
  dest   = {},
  name   = {},
  health = {},
  hud    = {},
  hitbox = {},
  pos    = {},
  sel    = {},
  sprite = {}
 }
 return c
end

function cmp_add_animation(id, frame_duration, frames)
 add(cmp.anim, {id = id, frame_duration = frame_duration, time = 0, frame_current_index = 1, frames = frames})
end

function cmp_add_destination(id, x, y)
 add(cmp.dest, {id = id, x = x, y = y})
end

function cmp_add_name(id, value)
 add(cmp.name, {id = id, value = value})
end

function cmp_add_health(id, val)
 add(cmp.health, {id = id, maximum = val, value = val})
end

function cmp_add_hitbox(id, x, y, w, h)
 add(cmp.hitbox, {id = id, x = x, y = y, w = w, h = h}) end

function cmp_add_hud(id, sx, sy)
 add(cmp.hud, {id = id, sx = sx, sy = sy})
end

function cmp_add_position(id, x, y)
 add(cmp.pos, {id = id, x = x, y = y})  
end

function cmp_add_select(id, groupable)
 add(cmp.sel, {id = id, groupable = groupable, value = 0})
end

function cmp_add_sprite(id, spr_num, w, h)
 add(cmp.sprite, {id = id, num = spr_num, w = w, h = h, flip = false})
end

function cmp_anim_get_index(id)
 local i
 local anim = cmp.anim
 for i = 1, #anim do
  if anim[i].id == id then
   return i
  end
 end
 return 0
end

function cmp_dest_get_index(id)
 local i
 local dest = cmp.dest
 for i = 1, #dest do
  if dest[i].id == id then
   return i
  end
 end
 return 0
end

function cmp_name_get_index(id)
 local i
 local name = cmp.name
 for i = 1, #name do
  if name[i].id == id then
   return i
  end
 end
 return 0
end

function cmp_health_get_index(id)
 local i
 local health = cmp.health
 for i = 1, #health do
  if health[i].id == id then
   return i
  end
 end
 return 0
end

function cmp_hitbox_get_index(id)
 local i
 local hitbox = cmp.hitbox
 for i = 1, #hitbox do
  if hitbox[i].id == id then
   return i
  end
 end
 return 0
end

function cmp_hud_get_index(id)
 local i
 local hud = cmp.hud
 for i = 1, #hud do
  if hud[i].id == id then
   return i
  end
 end
 return 0
end

function cmp_pos_get_index(id)
 local i
 local pos = cmp.pos
 for i = 1, #pos do
  if pos[i].id == id then
   return i
  end
 end
 return 0
end

function cmp_sel_get_index(id)
 local i
 local sel = cmp.sel
 for i = 1, #sel do
  if sel[i].id == id then
   return i
  end
 end
 return 0
end

function cmp_sprite_get_index(id)
 local i
 local sprite = cmp.sprite
 for i = 1, #sprite do
  if sprite[i].id == id then
   return i
  end
 end
 return 0
end

-->8
--entities
function ent_add_grunt(id, x, y)
 cmp_add_animation(id, 10, {1, 2})
 cmp_add_destination(id, x, y)
 cmp_add_name(id, "grunt")
 cmp_add_health(id, 10)
 cmp_add_hitbox(id, x, y, 8, 8)
 cmp_add_hud(id, 8, 0) 
 cmp_add_position(id, x, y)
 cmp_add_select(id, 1)
 cmp_add_sprite(id, 1, 1, 1)
end

function ent_add_house(id, x, y)
 cmp_add_animation(id, 10, {1, 2})
 cmp_add_destination(id, x, y)
 cmp_add_name(id, "house")
 cmp_add_health(id, 10)
 cmp_add_hitbox(id, x, y, 8, 8)
 cmp_add_hud(id, 8, 0) 
 cmp_add_position(id, x, y)
 cmp_add_select(id, 1)
 cmp_add_sprite(id, 1, 1, 1)
end

function ent_delete(id)
 local i = 0
 i = cmp_anim_get_index(id)
 if i != 0 then deli(cmp.anim, i) end

 i = cmp_dest_get_index(id)
 if i != 0 then deli(cmp.dest, i) end

 i = cmp_name_get_index(id)
 if i != 0 then deli(cmp.name, i) end

 i = cmp_health_get_index(id)
 if i != 0 then deli(cmp.health, i) end

 i = cmp_hitbox_get_index(id)
 if i != 0 then deli(cmp.hitbox, i) end

 i = cmp_hud_get_index(id)
 if i != 0 then deli(cmp.hud, i) end

 i = cmp_pos_get_index(id)
 if i != 0 then deli(cmp.pos, i) end

 i = cmp_sel_get_index(id)
 if i != 0 then deli(cmp.sel, i) end

 i = cmp_sprite_get_index(id)
 if i != 0 then deli(cmp.sprite, i) end

end

-->8
--systems

function sys_animate()
 local i, j, k
 for i = 1, #cmp.anim do
  if(#cmp.anim[i].frames > 1) then
   if(cmp.anim[i].time > 0) then
    cmp.anim[i].time -= 1
   elseif(cmp.anim[i].time == 0) then
    if(cmp.anim[i].frame_current_index < #cmp.anim[i].frames) then
     cmp.anim[i].frame_current_index += 1
    else
     cmp.anim[i].frame_current_index = 1
    end 
    j = cmp_sprite_get_index(cmp.anim[i].id)
    k = cmp.anim[i].frame_current_index
    cmp.sprite[j].num = cmp.anim[i].frames[k] 
    cmp.anim[i].time = cmp.anim[i].frame_duration
   end
  end
 end
end

function sys_draw_hud()
 local hx1 = 0 
 local hy1 = 94
 local hx2 = 127
 local hy2 = 127
 local sepx1 = 33
 local sepx2 = 94
 local bg = 1
 local fnt = 7
 local big_spr_w = 32
 local big_spr_h = 32
 local small_spr_w = 8
 local small_spr_h = 8

 rectfill(hx1, hy1, hx2, hy2, bg)   --hud bg
-- line(hx1, hy1, hx2, hy1, 7)        --hud top line
 --line(sepx1, hy1 + 1, sepx1, hy2, 2)  --separator line 1
 --line(sepx2, hy1 + 1, sepx2, hy2, 2)  --separator line 2

-- sspr(sx, sy, sw, sh, dx, dy, [dw], [dh], [flip_x], [flip_y])

 local ents_selected = {}
 local n_cols = 5    -- how many sprites wide can the rows of selected ents be.
 local sel = cmp.sel
 local hud = cmp.hud
 local name = cmp.name
 local sprite = cmp.sprite
 local health = cmp.health
 local i, h, hp, s, c, sw, sh, pad
 for i = 1, #sel do
  if (sel[i].value == 1) then
   add(ents_selected, sel[i].id)
  end
 end 
 if (#ents_selected == 1) then                --one unit is selected.
  h = cmp_hud_get_index(ents_selected[1])
  hp = cmp_health_get_index(ents_selected[1])
  s = cmp_sprite_get_index(ents_selected[1])
  c = cmp_name_get_index(ents_selected[1])
  sspr(
  hud[h].sx,         --sx
  hud[h].sy,         --sy
  sprite[s].w * 8,   --sw
  sprite[s].h * 8,   --sh
  sepx1 + 1,           --dx
  hy1 + 1,           --dy
  big_spr_w,         --dw
  big_spr_h,         --dh
  false, false)      --flip_x/flip_y
  print(name[c].value, sepx1 + 2 + big_spr_w, 97, fnt)          --selected unit name
  print(health[hp].value, sepx1 + 2 + big_spr_w, 103, fnt)      --selected unit health
  if(health[hp].value < 10) then 
   pad = 4
  elseif(health[hp].value < 100) then
   pad = 8
  else
   pad = 12
  end 

  print("/", sepx1 + 2 + pad + big_spr_w, 103, fnt)       --selected unit health
  print("10", sepx1 + 2 + pad + 4 + big_spr_w, 103, fnt)  --selected unit health

  spr(48, sepx1 + 2 + big_spr_w, 109)                --attack stats
  print("10",sepx1 + 14 + big_spr_w, 109, fnt)

  spr(32, sepx1 + 2 + big_spr_w, 115)                --defense stats
  print("12", sepx1 + 14 + big_spr_w, 115, fnt)

 elseif(#ents_selected > 1) then        --multiple units selected.
  local row = 0
  local col = 0
  for i = 1, #ents_selected do
   h = cmp_hud_get_index(ents_selected[i])
   hp = cmp_health_get_index(ents_selected[i])
   s = cmp_sprite_get_index(ents_selected[i]) 
   if (i == n_cols + 1) then
    row = 1
    col = 0
   elseif (i == (n_cols * 2) + 1) then
    row = 2
    col = 0
   elseif (i == (n_cols * 3) + 1) then
    row = 3
    col = 0
   end
   sspr(
   hud[h].sx,                        --sx
   hud[h].sy,                        --sy
   sprite[s].w*8,                    --sw
   sprite[s].h*8,                    --sh
   sepx1+2+(col*(small_spr_w+1)),     --dx
   hy1+2+(row*(small_spr_h+1)),      --dy
   small_spr_w,                      --dw
   small_spr_h,                      --dh
   false, false)                     --flip_x and flip_y
   col += 1
  end
 end
end

function sys_draw_entities()
 local i, j
 local pos = cmp.pos
 local sprite = cmp.sprite
 sys_intern_y_sort()
 --search ent positions
 --then matching ent sprites.
 for i = 1, #pos do
  for j = 1, #sprite do
   if pos[i].id == sprite[j].id then
    spr(sprite[j].num, pos[i].x, pos[i].y, sprite[j].w, sprite[j].h, false, sprite[j].flip)
   end
  end
 end
end

function sys_draw_healthbars()
 local i, j, k, h
 local x_offset, y_offset
 local sel = cmp.sel
 --local pos = cmp.pos
 --local health = cmp.health
 --local sprite = cmp.sprite
 for i = 1, #sel do
  if sel[i].value == 1 then
   j = cmp_pos_get_index(sel[i].id)
   k = cmp_hitbox_get_index(sel[i].id)
   h = cmp_health_get_index(sel[i].id)
   --the healthbar should be
   --centered over the entity
   --taking into account the
   --amount of hitpoints which
   --will make the bar longer.
   x_offset = cmp.pos[j].x + flr((cmp.hitbox[k].w) / 2) - flr(cmp.health[h].maximum / 2) 
   y_offset = cmp.pos[j].y - 2
   rectfill(x_offset, y_offset, x_offset + cmp.health[h].maximum, y_offset - 1, 8) 
   rectfill(x_offset, y_offset, x_offset + cmp.health[h].value, y_offset - 1, 11) 
  end
 end
end

function sys_intern_y_sort()
 local i, j, temp
 --sort pos table by y.
 for i = 1, #cmp.pos - 1 do
  for j = 1, #cmp.pos - i do 
   if cmp.pos[j].y > cmp.pos[j + 1].y then
    temp = cmp.pos[j + 1]
    cmp.pos[j + 1] = cmp.pos[j]
    cmp.pos[j] = temp
   end
  end
 end
end

function sys_move()
 local i, j
 local px, py
 local dx, dy
 local dest = cmp.dest
 local pos = cmp.pos
 for i = 1, #dest do
  dx = dest[i].x
  dy = dest[i].y
  j = cmp_pos_get_index(dest[i].id)
  px = pos[j].x
  py = pos[j].y
  if(px != dx or py != dy) then
   --ent moves to destination
  end
 end
end

function sys_update_destination(x, y)
 local i, j
 local sel = cmp.sel
 for i = 1, #sel do
  if(sel[i].value == 1)then
   j = cmp_dest_get_index(sel[i].id)
   cmp.dest[j].x = x
   cmp.dest[j].y = y
  end
 end
end

function sys_update_selected()
 local max_selectable = 15
 local j, k, l, p, s 
 local center_x, center_y 
 local box_is_too_small = 0
 local x1 = mouse.box_x1
 local y1 = mouse.box_y1
 local x2 = mouse.box_x2
 local y2 = mouse.box_y2
 local pos = cmp.pos
 local sprite = cmp.sprite
 local hitbox = cmp.hitbox
 
 --if the selection box is less
 --than 5 pixels wide *AND* less
 --than 5 pixels tall then
 --nothing is selected.
 if(max(x1,x2) - min(x1,x2) < 5 and max(y1, y2) - min(y1, y2) < 5) then
  box_is_too_small = 1
 end
 --search for entities that are
 --positioned inside the
 --selection box, then determine
 --their selection status.
 local n_selected = 0
 for j = 1, #pos do
  k = cmp_sel_get_index(pos[j].id)
  l = cmp_hitbox_get_index(pos[j].id)
  center_x = pos[j].x + flr(hitbox[l].w/2)
  center_y = pos[j].y + flr(hitbox[l].h/2)
  --mouse selection box
  if(box_is_too_small == 0) then
   if( 
   cmp.sel[k].groupable == 1
   and n_selected < max_selectable
   and min(x1, x2) < center_x
   and max(x1, x2) > center_x
   and min(y1, y2) < center_y
   and max(y1, y2) > center_y) then
    cmp.sel[k].value = 1
    n_selected += 1
   else
    cmp.sel[k].value = 0
   end
  elseif(box_is_too_small == 1) then
   --quick mouse click
   if abs(center_x - x1) < flr(hitbox[l].w/2)
   and abs(center_y - y1) < flr(hitbox[l].w/2) 
   and n_selected < max_selectable then
    cmp.sel[k].value = 1
    n_selected += 1
   else
    cmp.sel[k].value = 0
   end
  end   
 end
end

-->8
--mouse
 mouse = {
  pressed = 0,
  box_x1 = nil,
  box_y1 = nil,
  box_x2 = nil,
  box_y2 = nil
 }

function mouse_update()
 if(stat(34) == 1) then --left click
  if(mouse.pressed != 1) then
   mouse.pressed = 1
   mouse.box_x1 = stat(32)
   mouse.box_y1 = stat(33)
  end
  mouse.box_x2 = stat(32)
  mouse.box_y2 = stat(33)
 end
 if(stat(34) != 1 and mouse.pressed == 1) then
  sys_update_selected() 
  mouse.box_x1 = nil
  mouse.box_y1 = nil
  mouse.box_x2 = nil
  mouse.box_y2 = nil
  mouse.pressed = 0
 end
 
 if(stat(34) == 2) then --right click
  mouse.pressed = 2 
  sys_update_destination(stat(32), stat(33))
 end
end

function mouse_draw_selection_box()
 rect(mouse.box_x1, mouse.box_y1, mouse.box_x2, mouse.box_y2, 7)
end

-->8
--game loop
function _init()
 printh("----------------")
 screen = 1
 next_id = 1
 cls()
 poke(0x5f2d, 1) --enable mouse
 cmp = cmp_init()

  ent_add_grunt(next_id, 13, 39)
  cmp.health[next_id].value = 4
  next_id += 1
end

function _update()
 mouse_update()
 sys_animate()
end

function _draw()
 cls()
 --draw entities 
 sys_draw_entities()
 sys_draw_healthbars()
 sys_draw_hud()
 -- sspr(sx, sy, sw, sh, dx, dy, [dw], [dh], [flip_x], [flip_y])

 --mouse cursor
 spr(16,stat(32)-1, stat(33)-1)

 --mouse selection box
 if(stat(34) == 1) then
  mouse_draw_selection_box()
 end

end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000ee20000000000000000000000000000000000000000000000000bbbbbb00000000000000000000000000000
0070070000eeee00000000000000000000eeee0002ee00e000000000000000000000000000eeee0000000000000bbbbbbbbbb000000000000000000000000000
0007700000e2e20000eeee0000eeee0000e2e2000eecccc000000000000000000000000000e2e20000eeee00000bbbbbbbbbb000000000000000000000000000
0007700000eeee0000e2e2004442e20000eeee000eecccc00eeeccc0000000000000000000eeee0000e2e20000bbbbbbbbbbbb00000000000000000000000000
0070070000cccc0000eeee00444eee0000cccc440000ccc00eeeccc00eeeccc00eeeccc000cc444000eeee0000bbbbbbbbbbbb00000000000000000000000000
0000000000cccc0000cccc000ecccc0000cc4e440e0000000eeeccc00eeeccc08eeeccc800ce555e00cc444000bbbbbbbbbbbb00000000000000000000000000
0000000000cccc0000cccc0004cccc0000cccc440000000000000000008888000888888000cccc0000ce555e00bbbbbbbbbbbb00000000000000000000000000
0100000000000000000000000000000000000000080000000000000000000000000000000009a0000000000000bbbbbbbbbbbb00000000000000000000000000
17100000088800000000000008880000008800008c2200000000000000000000000000000099aa0000000000005bbbbbbbbbb500000000000000000000000000
1771000008cccc000888000005cccc00008ccc008c2c00c00000000000000000000000000999aaa0000000000005bbbbbbbb5000000000000000000000000000
1777100088c2220008cccc0085c22200088c22008cccccc00000000000000000000000009999aaaa000000000005555555555000000000000000000000000000
1777710000cc2c5088c2220005cc2c5000ccc2000cccccc00c2cccc00000000000000000999ddaaa000000000000155555510000000000000000000000000000
1771100000cccc5500cc2c500ccccc5500cccc00000cccc00cccccc00c2cccc00c2cccc099d66daa000000000000011221100000000000000000000000000000
011710000c555c5000cccc5500cccc5000ccc5550c0000000cccccc00cccccc08cccccc89244442a000000000000000440000000000000000000000000000000
0000000000cccc000c555c5000cccc0000cccc000000000000000000008888000888888006655660000000000000000000000000000000000000000000000000
777770000000000000000000000000000000000000000000000000000000009a9a00000000000000000000000000000000000000000000000000000000000000
7777700000000000000000000000000000000000000000000000000000000999aaa0000000000000000000000000000000000000000000044000000000000000
777770000000000000000000000000000000000000000000000000000000999a9aaa000000000000000000000000000000000000000004499440000000000000
0777000000000000000000000000000000000000000000000000000000099999aaaaa00000000000000000009990000000000000000449999994400000000000
007000000000000000000000000000000000000000000000000000000009999a9aaaa00000000000000000999999000000000000044999999999944000000000
0000000000000000000000000000000000000000000000000000000000999999aaaaaa0000000000000004999999900000000000499999999999999200000000
000000000000000000000000000000000000000000000000000000000099999d2aaaaa0000000000000046499999990000000000444999999999922200000000
00000000000000000000000000000000000000000000000000000000009999d64daaaa0000000000000466649999900000000000464449999992255200000000
0007700000000000000000000000000000000000000000000000000000999266462aaa0000000000004666664999500000009900464444499225555200000000
007770000000000000000000000000000000000000000000000000000099d466464daa0000000000044446666495500000999990464554644555555200000000
77770000000000000000000000000000000000000000000000000000009d64664646da0000000000006644444455500009999999464554664555555200000000
077000000000000000000000000000000000000000000000000000000094444444444a0000000000006645466555000092999999044554664555522000000000
70700000000000000000000000000000000000000000000000000000000666411466600000000000006645466550000022299994000444664552200000000000
00000000000000000000000000000000000000000000000000000000000066415466000000000000000005466500000024229444000004464220000000000000
0000000000000000000000000000000000000000000000000000000000000645d460000000000000000000000000000024224440000000044000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000224400000000000000000000000000
3333339a9a3333333333333333333333333333333333333300000000000000000000000000000000000000000000000000000000000000000000000000000000
33333999aaa333333333333333333333333333333333333300000000000000000000000000000000000000000000000000000000000000000000000000000000
3333999a9aaa33333333333333333333333333333333333300000000000000000000000000000000000000000000000000000000000000000000000000000000
33399999aaaaa3333333333333333333333333333333333300000000000000000000000000000000000000000000000000000000000000000000000000000000
3339999a9aaaa3333333333333333333333333333333333300000000000000000000000000000000000000000000000000000000000000000000000000000000
33999999aaaaaa333336666666666666666666666666633300000000000000000000000000000000000000000000000000000000000000000000000000000000
3399999d2aaaaa333365dddddddddddddddddddddddd563300000000000000000000000000000000000000000000000000000000000000000000000000000000
339999d64daaaa333365dddddddddddddddddddddddd563300000000000000000000000000000000000000000000000000000000000000000000000000000000
33999266462aaa3333655dddddddddddddddddddddd5563300000000000000000000000000000000000000000000000000000000000000000000000000000000
3399d466464daa3333655dddddddddddddddddddddd5563300000000000000000000000000000000000000000000000000000000000000000000000000000000
339d64664646da3333655dddddddddddddddddddddd5563300000000000000000000000000000000000000000000000000000000000000000000000000000000
3394444444444a33336555dddddddddddddddddddd55563300000000000000000000000000000000000000000000000000000000000000000000000000000000
33366641146663333365553333333333333333333355563300000000000000000000000000000000000000000000000000000000000000000000000000000000
33336641546633333365553333333333333333333355563300000000000000000000000000000000000000000000000000000000000000000000000000000000
33336645d46633333365553333333333333333333355563300000000000000000000000000000000000000000000000000000000000000000000000000000000
33333664d66333333365553333333333333333333355563300000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000003365553333333333333333333355563300000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000003365553333333333333333333355563300000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000003365553333333333333333333355563300000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000003365553333333333333333333355563300000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000003365553333333333333333333355563300000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000003365553333333333333333333355563300000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000003365553333333333333333333355563300000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000003365553333333333333333333355563300000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000003365553333333333333333333355563300000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000003365553333333333333333333355563300000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000003366666666666666666666666666663300000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000003366666666666666666666666666663300000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000003336666666666666666666666666633300000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000003336666666666666666666666666633300000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000003333666666666666666666666666333300000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000003333366666666666666666666663333300000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0b0c0b0c0b0c0b0c0b0c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1b1c1b1c1b1c1b1c1b1c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2127282728272819191900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2137383738373819191900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0b0c210421132119191900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1b1c212114191919191900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000191900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
