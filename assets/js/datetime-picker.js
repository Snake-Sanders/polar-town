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
        const input = document.querySelector("#reservation-form_time_start");
        input.value = dateStr;
        // this.pushEvent("date-updated");
        
    }
}

export default DateTimePicker;
