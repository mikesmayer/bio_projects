SeqResults.ProjectRoute = Ember.Route.extend({
  setupController: function(controller, model) {
    model.setProperties({
      original_id: model.id
    });
    controller.set('model', model);
  }
});
