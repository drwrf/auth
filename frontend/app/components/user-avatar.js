import Ember from 'ember';
export default Ember.Component.extend({
  user: null,
  src: function() {
    return 'http://www.gravatar.com/avatar/' + md5(this.get('user.email'));
  }.property('user.email')
});
