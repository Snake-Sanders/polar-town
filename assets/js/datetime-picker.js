import flatpickr from "../vendor/flatpickr";
import { config } from "../vendor/topbar";

// https://flatpickr.js.org/examples/

class DateTimePicker{
    
    constructor(element) {
        const config = {
            minDate: "today",
            maxDate: new Date().fp_incr(14),
            mode: "range",
            defaultDate: "today",
            conjuction: " - ",
            inline: true,
            onClose: (dateList, dateStr, instance) => {
                this.update_input(dateList, dateStr, instance);
            }
        };

        flatpickr(element, config);
    }

    // puts into the input field the date and time selected with flatpickr
    update_input(dateList, dateStr, instance) {
        let dateStart = instance.parseDate(dateList[0], "Y-m-d h:i K")
        
        console.log("FlatPickr closed:" + dateStart);
        let input_start = document.querySelector("#reservation-form_time_start");
        let input_end = document.querySelector("#reservation-form_time_end");
        
        switch(dateList.length)
        {
            case 1: 
            {
                input_start.value = dateList[0];
                input_end.value = dateList[0];
                break;
            }
            case 2: 
            {
                input_start.value = dateList[0];
                input_end.value = dateList[1];
                break;
            }
        }
        // TODO: use alt text to show the range dates in the start date field
        // input_start = dateStr;
        // this.pushEvent("date-updated");
        
    }
}

export default DateTimePicker;
