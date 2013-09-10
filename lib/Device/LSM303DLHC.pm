package Device::LSM303DLHC;

# PODNAME: Device::LSM303DLHC 
# ABSTRACT: I2C interface to LSM303DLHC 3 axis magnetometer(compass) and accelerometer using Device::SMBus
# COPYRIGHT
# VERSION

use 5.010;
use Moose;
use POSIX

has Compass => (
    is => 'ro'
    isa => 'Device::SMBus' 
);

has Accelerometer => (
    is => 'ro'
    isa => 'Device::SMBus' 
);
1;
