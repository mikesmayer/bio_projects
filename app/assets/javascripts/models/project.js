SeqResults.Project = DS.Model.extend({
  readGroups: DS.hasMany('readGroup', { async: true }),
  runs: DS.hasMany('run', { async: true }),
  name: DS.attr('string'),
  readGroupCount: DS.attr('number')
});