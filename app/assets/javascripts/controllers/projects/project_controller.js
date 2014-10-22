SeqResults.ProjectController = Ember.ObjectController.extend({
  actions: {
      save: function(){
        var originalID = this.get('model').original_id;
        var newID = this.get('model').id;

        $.ajax({
          url: '/projects/'+originalID,
          type: 'PUT',
          data: {'new_id': newID},
          context: this,
          success: function() {
//            this.get('model').save();
            this.transitionToRoute('project');
          },
          fail: function(){
            alert("Something went wrong, contact the administrator");
          }
        });

      }
    }
});