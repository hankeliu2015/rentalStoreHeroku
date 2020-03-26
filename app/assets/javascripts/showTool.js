$(document).on(("turbolinks:load"), function() {
  showToolClickHandlers();
})

// $(document).ready(function(){
//   showToolClickHandlers()
// })

const showToolClickHandlers = function(){
  $("a#show-tool").on("click", function(e){
    e.preventDefault();

    let id = parseInt(this.dataset["toolId"])

    $.get(`tools/${id}.json`, function(resp_obj){

      history.pushState("null", "null", `tools/${id}`)

      let newTool = new Tool(resp_obj)

      let toolHTML = newTool.formatTool()

      let calendarObj = $(".tool-calendar")[0];

      $("#tool-container").html("")
      $("#tool-container").html(toolHTML)

      if (newTool.rentalInProgress) {
          let rentalHTML = newTool.formatToolRentalInProgress();
          $("#tool-container").append(rentalHTML)
        } else if (newTool.rentalOverdued) {
          let overduedHTML = newTool.formatToolRentalOverdued();
          $("#tool-container").append(overduedHTML)
        } else if (newTool.rentalsScheduled.length !== 0) {
          // debugger
          let msgHTML = `<h5>This tool is booked for the following days:</h5>`
          $("#tool-container").append(msgHTML)
          newTool.rentalsScheduled.forEach(function(scheduledRental, i){
            console.log("inside scheduled")
            // debugger
            let scheduledHTML = newTool.formatToolRentalScheduled(scheduledRental);

            $("#tool-container").append(scheduledHTML)
          })
        }
        //keep data-toolid lowercase.
        let rentButtonHTML = `
          <button type="button" class="rent-button" data-toolid=${id}>Check Availability</button>
          <br>
        `
        $("#tool-container").append(rentButtonHTML)

        $("#tool-container").append(displayToolCalendar(calendarObj))

    })
  })

  $(document).on("click", ".rent-button", function(e){
    e.preventDefault();
    let rentalToolId = parseInt(e.target.dataset.toolid)

    window.location.href = `http://localhost:3000/tools/${rentalToolId}/rentals/new`;
  })

  $(document).on("click", ".toolRentalsCounter", function(e) {
      e.preventDefault();
      let toolId = parseInt(e.target.dataset.toolid)
      // let toolRentalsCompleted = e.target.dataset.toolRentalsCount

      $.get(`/tools/${toolId}.json`, function(resp_obj){
        let toolRentalsArray = resp_obj.rentals_completed;
        toolRentalsArray.forEach(function(rental, i) {
          // debugger
          let arrRental = [rental] //have to convert to array for Rental constructor in rentalsHistory.js

          let eachRental = new Rental(arrRental)

          let custom_start_date = new Date(eachRental.start_date)
          let custom_return_date = new Date(eachRental.return_date)

          let rentalHTML = `
            <tr>
              <td>${i+1}.</td>
              <td>Rented: ${custom_start_date.toDateString()}</td>
              <td>Returned: ${custom_return_date.toDateString()}</td>
            </tr>
          `
         $(".toolRentalsList").append(rentalHTML)
        })
      })
  })
}

const displayToolCalendar = function(calObj) {
  // const toolCal = $(".tool-calendar")[0];

  if (calObj.style.display === 'none') {
    calObj.style.removeProperty('display');
    return calObj
  }
}

class Tool {
  constructor(tool) {
    this.id = tool.id
    this.name = tool.name
    this.brand = tool.brand
    this.description = tool.description
    this.condition = tool.condition
    this.rental_price = tool.rental_price
    this.image = tool.image
    this.rentalInProgress = tool.rental_in_progress
    this.rentalOverdued = tool.rental_overdued
    this.rentalsScheduled = tool.rentals_scheduled
    this.rentalsCompleted = tool.rentals_completed
  }

  formatTool() {
    let val = `
      <h4> ${this.name} </h4>
      <ul>
        <img class="tool_image" src="/assets/${this.image}"  alt="${this.name}" height="120" width="120">
        <li>Description: ${this.description} </li>
        <li>Brand: ${this.brand} </li>
        <li>Rental Price: $ ${this.rental_price} </li>
        <li>Condition: ${this.condition} </li>
        <li>Rented by Customer: <a class="toolRentalsCounter" data-toolid=${this.id} data-toolRentalsCount=${this.rentalsCompleted} href=#> ${this.rentalsCompleted.length} times. (click for details)</a> </li>
      </ul>
        <table class="toolRentalsList">
          <tr>More details: </tr>
        </table>
    `
    return val
  }

  formatToolRentalCompleted() { // not in use for now.
    let toolRentArr = this.toolRentalCompleted
  }

  formatToolRentalInProgress() {
    let customized_start_date = new Date(this.rentalInProgress.start_date)
    let customized_return_date = new Date(this.rentalInProgress.return_date)

    let val = `
      <h6>Tool is not available right now. Please use the check availability button to find available dates to rent: </h6>

      <li>Rented on: ${customized_start_date.toDateString()} </li>
      <li style="color:maroon">Return Date: ${customized_return_date.toDateString()} </li>
    `
    return val
  }

  formatToolRentalOverdued() {

    let convertedStartDate = this.treatAsUTC(this.rentalOverdued.start_date)
    let convertedReturnDate = this.treatAsUTC(this.rentalOverdued.return_date)


    let today = new Date()
    let convertedToday = this.treatAsUTC(today)

    let daysOverdued = parseInt(this.daysBetween(convertedToday, convertedReturnDate))

    let val = `
      <h6 style="color:maroon"> Tool is Overdued for ${daysOverdued} days and not available for rent. Sorry!</h6>

      <li>Rented on: ${convertedStartDate.toDateString()}</li>
      <li>Return Date: ${convertedReturnDate.toDateString()}</li>
    `
    return val
  }

  treatAsUTC(date) {
        var result = new Date(date);
        result.setMinutes(result.getMinutes() - result.getTimezoneOffset());
        return result;
    }

  daysBetween(recentDate, pastDate) {
      var millisecondsPerDay = 24 * 60 * 60 * 1000;
      return (this.treatAsUTC(recentDate) - this.treatAsUTC(pastDate)) / millisecondsPerDay;
  }

  formatToolRentalScheduled(rental) {
    let customizedStartDate = new Date(rental.start_date)
    let customizedReturnDate = new Date(rental.return_date)
    // debugger
    let val = `
      <ul>
        <li>Booked on: ${customizedStartDate.toDateString()} ; Return Date: ${customizedReturnDate.toDateString()} </li>
      </ul>
    `
    return val
  }
}

// replaced by above class syntax
// function Tool (tool) {
//   this.id = tool.id
//   this.name = tool.name
//   this.brand = tool.Brand
//   this.description = tool.description
//   this.condition = tool.condition
//   this.rental_price = tool.rental_price
//   this.image = tool.image
//   this.rentalInProgress = tool.rental_in_progress
//   this.rentalOverdued = tool.rental_overdued
// }
//
// Tool.prototype.formatTool = function() {
//   // debugger
//   let val = `
//     <h4> ${this.name} </h4>
//     <ul>
//       <img class="tool_image" src=assets/${this.image}  alt="Tool image" height="100" width="100">
//       <li>Description: ${this.description} </li>
//       <li>Brand: ${this.brand} </li>
//       <li>Rental Price: $ ${this.rental_price} </li>
//       <li>Condition: ${this.condition} </li>
//     </ul>
//   `
//   return val
// }
