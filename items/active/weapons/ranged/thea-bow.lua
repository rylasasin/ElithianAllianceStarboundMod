require "/scripts/util.lua"
require "/scripts/vec2.lua"
require "/items/active/weapons/weapon.lua"

function init()
  self.cursor = config.getParameter("cursor")
  
  if (self.cursor) then
    activeItem.setCursor(self.cursor)
  else
    activeItem.setCursor("/cursors/reticle0.cursor")
  end

  self.weapon = Weapon:new()

  self.weapon:addTransformationGroup("weapon", {0,0}, 0)

  local primaryAbility = getPrimaryAbility()
  self.weapon:addAbility(primaryAbility)

  local secondaryAttack = getAltAbility(self.weapon.elementalType)
  if secondaryAttack then
    self.weapon:addAbility(secondaryAttack)
  end

  self.weapon:init()
end

function update(dt, fireMode, shiftHeld)
  self.weapon:update(dt, fireMode, shiftHeld)
  
  local primaryAbility = getPrimaryAbility()
  world.debugPoint(vec2.add(mcontroller.position(), activeItem.handPosition(primaryAbility.fireOffset)), "red")
end

function uninit()
  self.weapon:uninit()
end
