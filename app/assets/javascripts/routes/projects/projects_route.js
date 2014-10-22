SeqResults.ProjectsRoute = Ember.Route.extend({
  model: function(params) {
    this.get('store').findAll('project').then(function(projects){
      projects.content.forEach(function(project) {
        project.reload()
      });
    });

    return this.get('store').findAll('project')
  }
});