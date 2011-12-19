allScenariosPass = (scenarios) ->

  for scenario in scenarios
    if scenario.status != 'pass' then return false
  return true


module.exports = allScenariosPass
