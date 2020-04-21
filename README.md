# DemoBluetooth

This app is willing to experiment on Covid19 lockdown peer-tracking strategy

It is basically a demo Catalyst application that demonstrates how to use `CoreBluetooth` to:
* generate generate an unique identifier (uuid) per time period
* advertise that the application is running on the device
* scan for other nearby devices that are also running the application. 
* record user's uuids list on device
* record (encrypted) other's uuids
* download infected uuids list from central authority (mockup)
* compare other's uuids with infected uuids list
* warn user if infected uuid has been met

+

* provide support for QR flashing : if validated, user's uuid list is beeing sent to central authority
