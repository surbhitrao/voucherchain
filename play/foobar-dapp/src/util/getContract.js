import Web3 from 'web3'
import {address, ABI} from './constants/restaurants'

let getContract = new Promise(function (resolve, reject) {
  let web3 = new Web3(window.web3.currentProvider)
  let restaurants = web3.eth.contract(ABI)
  let restaurantsInstance = restaurants.at(address)
  // restaurantsInstance = () => restaurantsInstance
  resolve(restaurantsInstance)
})

export default getContract
