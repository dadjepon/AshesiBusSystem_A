import axios from 'axios';

export function getDrivers() {
  return axios.get('http://127.0.0.1:8000/drivers/')
    .then(response => response.data)
}

export function deleteDriver(driver_id) {
  return axios.delete('http://127.0.0.1:8000/drivers/' + driver_id + '/', {
   method: 'DELETE',
   headers: {
     'Accept':'application/json',
     'Content-Type':'application/json'
   }
  })
  .then(response => response.data)
}

export function addDriver(driver){
  return axios.post('http://127.0.0.1:8000/drivers/', {
    driver_id:null,
    driver_ashesi_id:driver.driver_ashesi_id.value,
    fname:driver.fname.value,
    lname:driver.lname.value,
    phone_number:driver.phone_number.value
  })
    .then(response=>response.data)
}

export function updateDriver(driid, driver) {
  return axios.put('http://127.0.0.1:8000/drivers/' + driid + '/', {
    driver_ashesi_id:driver.driver_ashesi_id.value,
    fname:driver.fname.value,
    lname:driver.lname.value,
    phone_number:driver.phone_number.value
  })
   .then(response => response.data)
}