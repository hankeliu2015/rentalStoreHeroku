$(document).on(("turbolinks:load"), function() {
  showToolClickHandlers();
})

// $(document).ready(function(){
//   showToolClickHandlers()
// })

const showToolClickHandlers = function(){
  $("a#show-tool").on("click", function(e){
    e.preventDefault();
    // history.pushState("null", "null", "tool")
    let id = parseInt(this.dataset["toolId"])

    $.get(`tools/${id}.json`, function(resp_obj){

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

        //create a rent button here.
        let rentButtonHTML = `
          <button type="button" class="rent-button">Rent</button>
          <br>
        `
        $("#tool-container").append(rentButtonHTML)

        $("#tool-container").append(displayToolCalendar(calendarObj))
        // displayToolCalendar(calendarObj)
        // $("#tool-container").append(calendarObj)
        // let simpleCalendar = $(".hidden-calendar").html()
        // $(".show-calendar").append(simpleCalendar)
    })
  })
}

const displayToolCalendar = function(calObj) {
  // const toolCal = $(".tool-calendar")[0];

  if (calObj.style.display === 'none') {
    calObj.style.removeProperty('display');
    return calObj

    // return $(".tool-calendar").html()
    // the following also works.
    // $(".tool-calendar").show()
    // $(".tool-calendar").css({ display: "block" });
  }
}

class Tool {
  constructor(tool) {
    this.id = tool.id
    this.name = tool.name
    this.brand = tool.Brand
    this.description = tool.description
    this.condition = tool.condition
    this.rental_price = tool.rental_price
    this.image = tool.image
    this.rentalInProgress = tool.rental_in_progress
    this.rentalOverdued = tool.rental_overdued
    this.rentalsScheduled = tool.rentals_scheduled
  }

  formatTool() {
    let val = `
      <h4> ${this.name} </h4>
      <ul>
        <img class="tool_image" src=assets/${this.image}  alt="Tool image" height="120" width="120">
        <li>Description: ${this.description} </li>
        <li>Brand: ${this.brand} </li>
        <li>Rental Price: $ ${this.rental_price} </li>
        <li>Condition: ${this.condition} </li>
      </ul>
    `
    return val
  }

  formatToolRentalInProgress() {
    let customized_start_date = new Date(this.rentalInProgress.start_date)
    let customized_return_date = new Date(this.rentalInProgress.return_date)

    let val = `
      <h6>Tool is not available right now. Please schedule rental dates base on the return date: </h6>

      <li>Rented on: ${customized_start_date.toDateString()} </li>
      <li style="color:maroon">Return Date: ${customized_return_date.toDateString()} </li>
    `
    return val
  }

  formatToolRentalOverdued() {

    // let todayDate = new Date().toDateString()
    // let startDate = new Date(this.rentalOverdued.start_date)
    // let returnDate = new Date(this.rentalOverdued.return_date)

    let convertedStartDate = this.treatAsUTC(this.rentalOverdued.start_date)
    let convertedReturnDate = this.treatAsUTC(this.rentalOverdued.return_date)
    // debugger

    let today = new Date()
    let convertedToday = this.treatAsUTC(today)

    // debugger

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
