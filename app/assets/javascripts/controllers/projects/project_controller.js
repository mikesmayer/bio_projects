SeqResults.ProjectController = Ember.ObjectController.extend({
  actions: {
      save: function(){
        this.get('model').save()
      },
      delete: function(){
        var readGroupCount = this.get('model').get('readGroupCount');
        if (window.confirm("Are you sure you want to delete this project with " + readGroupCount + " read groups?")){
          this.get('model').deleteRecord();
          this.get('model').save();
          this.transitionToRoute('projects')
        }
      }
    }
});