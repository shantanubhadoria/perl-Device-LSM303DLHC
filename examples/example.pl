use FindBin qw($Bin);
use lib "$Bin/../lib";

use Device::LSM303DLHC::Compass;
use Device::LSM303DLHC::Accelerometer;

my $a = Device::LSM303DLHC::Accelerometer->new(I2CBusDevicePath => '/dev/i2c-1');
my $c = Device::LSM303DLHC::Compass->new(I2CBusDevicePath => '/dev/i2c-1');
$a->enable();
$c->enable();
use Data::Dumper;
while(){
    print 'COMPASS: ' . Dumper {$c->getRawReading()};
    print 'ACCELEROMETER: ' . Dumper {$a->getRawReading()};
}
