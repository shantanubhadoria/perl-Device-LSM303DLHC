use FindBin qw($Bin);
use lib "$Bin/../lib";

use Device::LSM303DLHC;
#use Device::LSM303DLHC::Compass;
#use Device::LSM303DLHC::Accelerometer;

my $dev = Device::LSM303DLHC->new(I2CBusDevicePath => '/dev/i2c-1');
#my $a = Device::LSM303DLHC::Accelerometer->new(I2CBusDevicePath => '/dev/i2c-1');
#my $c = Device::LSM303DLHC::Compass->new(I2CBusDevicePath => '/dev/i2c-1');
$dev->Compass->enable();
$dev->Accelerometer->enable();
use Data::Dumper;
while(){
    print 'COMPASS: ' . Dumper {$dev->Compass->getRawReading()};
    print 'ACCELEROMETER: ' . Dumper {$dev->Accelerometer->getRawReading()};
}
