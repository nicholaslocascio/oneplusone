$(function() {

  $.rails.allowAction = function(link) {
  if (!link.attr('data-confirm')) {
    return true;
  }
  $.rails.showConfirmDialog(link);
  return false;
};

$.rails.confirmed = function(link) {
  var html, message;
  link.removeAttr('data-confirm');
  link.trigger('click.rails');
  };

$.rails.showConfirmDialog = function(link) {
  var html, message;
  message = link.attr('data-confirm');
 // html = '<div class="modal small fade" id="teamDeleteModal" tabindex="-1" role="dialog" aria-labelledby="teamDeleteModal" aria-hidden="true"><div class="modal-dialog"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button><h3>Delete Confirmation</h3></div><div class="modal-body"><p class="error-text">Are you sure you want to delete <em id="nameOfToBeDeleted">ee</em>?</p></div><div class="modal-footer"><button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button><button class="btn btn-danger confirm" data-dismiss="modal">Delete</button></div></div></div></div>';
  html = '<div class="modal" id="confirmationDialog"><div class="modal-dialog"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button><h3>Delete Confirmation</h3></div><div class="modal-body"><p class="error-text">Are you sure you want to delete?</p></div><div class="modal-footer"><button data-dismiss="modal" class="btn">Cancel</button><a data-dismiss="modal" class="btn btn-danger confirm">Delete</a></div></div></div></div>'

  $(html).modal();
  return $('#confirmationDialog .confirm').on('click', function() {
    return $.rails.confirmed(link);
  });
};

});