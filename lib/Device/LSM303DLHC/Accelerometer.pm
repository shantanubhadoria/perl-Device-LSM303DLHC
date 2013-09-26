package Device::LSM303DLHC::Accelerometer;

# PODNAME: Device::LSM303DLHC::Accelerometer
# ABSTRACT: I2C interface to Accelerometer on the LSM303DLHC 3 axis magnetometer(compass) and accelerometer using Device::SMBus
# COPYRIGHT
# VERSION

# Dependencies
use 5.010;
use Moose;
use POSIX;

use Math::Trig;

extends 'Device::SMBus';

=attr I2CDeviceAddress

Containd the I2CDevice Address for the bus on which your Accelerometer is connected. It would look like 0x6b. Default is 0x19.

=cut

has '+I2CDeviceAddress' => (
    is      => 'ro',
    default => 0x19,
);

=attr gCorrectionFactor

This is a correction factor for converting raw values of acceleration in units of g or gravitational acceleration. It depends on the sensitivity set in the registers.

=cut

has 'gCorrectionFactor' => (
    is      => 'ro',
    default => 256
);

=attr gravitationAcceleration

This is the acceleration due to gravity in meters per second square usally represented as g. default on earth is around 9.8 although it differs from 9.832 near the poles to 9.780 at equator. This might also be different if you are on a different planet or in space.

=cut

has 'gravitationalAcceleration' => (
    is      => 'ro',
    default => 9.8
);

=attr mssCorrectionFactor

This attribute is built from the above two attributes automatically. This is usually gCorrectionFactor divided by gravitationalAcceleration. This is the inverse of relation between raw accelerometer values and its value in meters per seconds.

=cut

has 'mssCorrectionFactor' => (
    is         => 'ro',
    lazy_build => 1,
);

sub _build_mssCorrectionFactor {
    my ($self) = @_;
    $self->gCorrectionFactor/$self->gravitationalAcceleration;
}

use constant {
    PI => 3.14159265359,
};

# Registers for the Accelerometer 
use constant {
    CTRL_REG1_A => 0x20,
    CTRL_REG4_A => 0x23,
};

# X, Y and Z Axis magnetic Field Data value in 2's complement
use constant {
    OUT_X_H_A => 0x29,
    OUT_X_L_A => 0x28,

    OUT_Y_H_A => 0x2b,
    OUT_Y_L_A => 0x2a,

    OUT_Z_H_A => 0x2d,
    OUT_Z_L_A => 0x2c,
};


=method enable 

    $self->enable()

Initializes the device, Call this before you start using the device. This function sets up the appropriate default registers.
The Device will not work properly unless you call this function

=cut

sub enable {
    my ($self) = @_;
    $self->writeByteData(CTRL_REG1_A,0b01000111);
    $self->writeByteData(CTRL_REG4_A,0b00101000);
}

=method getRawReading

    $self->getRawReading()

Return raw readings from accelerometer registers

=cut

sub getRawReading {
    my ($self) = @_;

    use integer; # Use arithmetic right shift instead of unsigned binary right shift with >> 4
    my $retval = {
        x => ( $self->_typecast_int_to_int16( ($self->readByteData(OUT_X_H_A) << 8) | $self->readByteData(OUT_X_L_A) ) ) >> 4,
        y => ( $self->_typecast_int_to_int16( ($self->readByteData(OUT_Y_H_A) << 8) | $self->readByteData(OUT_Y_L_A) ) ) >> 4,
        z => ( $self->_typecast_int_to_int16( ($self->readByteData(OUT_Z_H_A) << 8) | $self->readByteData(OUT_Z_L_A) ) ) >> 4,
    };
    no integer;

    return $retval;
}

=method getAccelerationVectorInG

returns four acceleration vectors with accelerations in multiples of g - (9.8 meters per second square)
note that even when stationary on the surface of earth(or a earth like planet) there is a acceleration vector g that applies perpendicular to the surface of the earth pointing opposite of the surface. 

=cut

sub getAccelerationVectorInG {
    my ($self) = @_;
    
    my $raw = $self->getRawReading;
    return {
        x => ($raw->{x})/$self->gCorrectionFactor,
        y => ($raw->{y})/$self->gCorrectionFactor,
        z => ($raw->{z})/$self->gCorrectionFactor,
    };
}

=method getAccelerationVectorInMSS

returns four acceleration vectors with accelerations in meters per second square
note that even when stationary on the surface of earth(or a earth like planet) there is a acceleration vector g that applies perpendicular to the surface of the earth pointing opposite of the surface. 

=cut

sub getAccelerationVectorInMSS {
    my ($self) = @_;
    
    my $raw = $self->getRawReading;
    return {
        x => ($raw->{x})/$self->mssCorrectionFactor,
        y => ($raw->{y})/$self->mssCorrectionFactor,
        z => ($raw->{z})/$self->mssCorrectionFactor,
    };
}

=method getAccelerationVectorInclination

returns  coorinate angles between the acceleration vector(R) and the cartesian Coordinates(x,y,z). 

=cut

sub getAccelerationVectorAngles {
    my ($self) = @_;
    
    my $raw = $self->getRawReading;

    my $rawR = sqrt($raw->{x}**2+$raw->{y}**2+$raw->{z}**2); #Pythagoras theorem
    return {
        Axr => _acos($raw->{x}/$rawR),
        Ayr => _acos($raw->{y}/$rawR),
        Azr => _acos($raw->{z}/$rawR),
    };
}

=method getRollYawPitch

returns  Roll, Yaw and Pitch from the accelerometer. This is a bare reading from accelerometer and it assumes gravity is the only force on the accelerometer, which means it will be quiet inacccurate for a moving accelerometer.

=cut

sub getRollYawPitch {
    my ($self) = @_;
    
    my $raw = $self->getRawReading;

    return {
        Pitch => atan2($raw->{y},$raw->{z})+PI,
        Roll  => atan2($raw->{x},$raw->{z})+PI,
    };
}

sub _acos { 
    atan2( sqrt(1 - $_[0] * $_[0]), $_[0] ) 
}
sub _typecast_int_to_int16 {
    return  unpack 's' => pack 'S' => $_[1];
}

sub calibrate {
    my ($self) =@_;

}

1;
