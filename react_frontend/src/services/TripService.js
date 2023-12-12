import axios from 'axios';

export function getTrips() {
  return axios.get('http://127.0.0.1:8000/trips/')
    .then(response => response.data)
}

export function deleteTrip(trip_id) {
  return axios.delete('http://127.0.0.1:8000/trips/' + trip_id + '/', {
   method: 'DELETE',
   headers: {
     'Accept':'application/json',
     'Content-Type':'application/json'
   }
  })
  .then(response => response.data)
}

export function addTrip(trip){
  return axios.post('http://127.0.0.1:8000/trips/', {
    trip_id:null,
    trip_name:trip.trip_name.value,
    trip_start_time:trip.trip_start_time.value,
    trip_end_time:trip.trip_end_time.value
  })
    .then(response=>response.data)
}

export function updateTrip(tid, trip) {
  return axios.put('http://127.0.0.1:8000/trips/' + tid + '/', {
    trip_name:trip.trip_name.value,
    trip_start_time:trip.trip_start_time.value,
    trip_end_time:trip.trip_end_time.value
  })
   .then(response => response.data)
}