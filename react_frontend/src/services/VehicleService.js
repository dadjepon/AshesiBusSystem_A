import axios from 'axios';

export function getVehicles() {
  return axios.get('http://127.0.0.1:8000/vehicles/')
    .then(response => response.data)
}

export function deleteVehicle(vehicle_id) {
  return axios.delete('http://127.0.0.1:8000/vehicles/' + vehicle_id + '/', {
   method: 'DELETE',
   headers: {
     'Accept':'application/json',
     'Content-Type':'application/json'
   }
  })
  .then(response => response.data)
}

export function addVehicle(vehicle){
  return axios.post('http://127.0.0.1:8000/vehicles/', {
    vehicle_id:null,
    vehicle_name:vehicle.vehicle_name.value,
    license_no:vehicle.license_no.value,
    model:vehicle.model.value,
    is_available:vehicle.is_available.value
  })
    .then(response=>response.data)
}

export function updateVehicle(vehid, vehicle) {
  return axios.put('http://127.0.0.1:8000/vehicles/' + vehid + '/', {
    vehicle_name:vehicle.vehicle_name.value,
    license_no:vehicle.license_no.value,
    model:vehicle.model.value,
    is_available:vehicle.is_available.value
  })
   .then(response => response.data)
}