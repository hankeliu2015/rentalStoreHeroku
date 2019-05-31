$(document).ready(function(){
  $('a#discount-rental').on('click', displayRentalForm)
})

function displayRentalForm(e) {
  e.preventDefault();
  let discoutToolId = parseInt(e.target.dataset.toolId) //tool_id not working.

  const discountRentForm = $(".hidden").html()
  $(`#formDiscountRental-${discoutToolId}`).html(discountRentForm)
  $(".hidden").html("")

  // $.('form')?? && toolId??
  $(`#formDiscountRental-${discoutToolId}`).submit(function(event) {
    e.preventDefault();
    debugger
    createDiscountRentalObj(event, toolId)
  })

  // do not delete yet.
  // $('.hidden').html(`<%= j render partial: 'rentals/form', locals: {user_rental: Rental.new(start_date: Date.today, return_date: Date.tomorrow, tool_id:${discoutToolId})} %>`);
}

function createDiscountRentalObj(e, idTool) {
  e.preventDefault();
  let value = $(this).serialize();
  let renting = $.post('rentals', value)
debugger
  //??

  // $.post('')
}
