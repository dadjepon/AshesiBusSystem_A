import axios from 'axios';

export function getLicenses() {
  return axios.get('http://127.0.0.1:8000/license/')
    .then(response => response.data)
}

export function deleteLicense(license_id) {
  return axios.delete('http://127.0.0.1:8000/license/' + license_id + '/', {
   method: 'DELETE',
   headers: {
     'Accept':'application/json',
     'Content-Type':'application/json'
   }
  })
  .then(response => response.data)
}

export function addLicense(license){
  return axios.post('http://127.0.0.1:8000/license/', {
    license_id:null,
    driver:license.driver.value,
    license_number:license.license_number.value,
    issue_date:license.issue_date.value,
    expiry_date:license.expiry_date.value,
    is_verified:license.is_verified.value
  })
    .then(response=>response.data)
}

export function updateLicense(lid, license) {
  return axios.put('http://127.0.0.1:8000/license/' + lid + '/', {
    driver:license.driver.value,
    license_number:license.license_number.value,
    issue_date:license.issue_date.value,
    expiry_date:license.expiry_date.value,
    is_verified:license.is_verified.value
  })
   .then(response => response.data)
}