part of '../../openmhealth_schemas.dart';

/// A measurement of ambient light, as a list of light wavelengths and their
/// intensities describing the composition of the ambient light.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/environment/ambient-light-1.0.json">ambient-light</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class AmbientLight extends Measure {
  static final SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'ambient-light',
    SchemaVersion.V1_0,
  );

  /// The individual light wavelengths and their intensities.
  List<AmbientLightComponent> ambientLight;

  AmbientLight({
    required this.ambientLight,
    required TimeFrame super.effectiveTimeFrame,
    super.descriptiveStatistic,
  });

  factory AmbientLight.fromJson(Map<String, dynamic> json) =>
      _$AmbientLightFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$AmbientLightToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// A light wavelength and its intensity in an [AmbientLight] measurement.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/environment/ambient-light-1.0.json">ambient-light</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class AmbientLightComponent {
  /// The wavelength of the light in nanometers ([LengthUnit.NANOMETER]).
  LengthUnitValue? wavelength;

  /// The intensity of the light.
  IlluminanceUnitValue intensity;

  AmbientLightComponent({required this.intensity, this.wavelength})
    : assert(
        wavelength == null || wavelength.unit == LengthUnit.NANOMETER,
        'The wavelength must be specified in nanometers (nm).',
      );

  factory AmbientLightComponent.fromJson(Map<String, dynamic> json) =>
      _$AmbientLightComponentFromJson(json);
  Map<String, dynamic> toJson() => _$AmbientLightComponentToJson(this);
}

/// A measurement of the ambient sound.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/environment/ambient-sound-1.0.json">ambient-sound</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class AmbientSound extends Measure {
  static final SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'ambient-sound',
    SchemaVersion.V1_0,
  );

  /// The ambient sound level.
  SoundUnitValue ambientSound;

  AmbientSound({
    required this.ambientSound,
    required TimeFrame super.effectiveTimeFrame,
    super.descriptiveStatistic,
  });

  factory AmbientSound.fromJson(Map<String, dynamic> json) =>
      _$AmbientSoundFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$AmbientSoundToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}

/// A measurement of the ambient temperature.
///
/// IEEE 1752.1 version 1.0
/// See <a href="https://opensource.ieee.org/omh/1752/-/blob/main/schemas/environment/ambient-temperature-1.0.json">ambient-temperature</a>
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class AmbientTemperature extends Measure {
  static final SchemaId SCHEMA_ID = SchemaId.withVersion(
    SchemaSupport.IEEE_NAMESPACE,
    'ambient-temperature',
    SchemaVersion.V1_0,
  );

  /// The ambient temperature.
  TemperatureUnitValue ambientTemperature;

  AmbientTemperature({
    required this.ambientTemperature,
    required TimeFrame super.effectiveTimeFrame,
    super.descriptiveStatistic,
  });

  factory AmbientTemperature.fromJson(Map<String, dynamic> json) =>
      _$AmbientTemperatureFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$AmbientTemperatureToJson(this);

  @override
  SchemaId getSchemaId() => SCHEMA_ID;
}
