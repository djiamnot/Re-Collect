#!/bin/bash

jack_connect pyo:output_1 system:playback_6
jack_connect pyo:output_2 system:playback_6
jack_connect pyo:output_3 system:playback_6
jack_connect pyo:output_4 system:playback_6
jack_connect pyo:output_5 system:playback_6
jack_connect system:capture_9 pyo:input_1
jack_connect system:capture_10 pyo:input_2
jack_connect system:capture_11 pyo:input_3
jack_connect system:capture_12 pyo:input_4
jack_connect system:capture_13 pyo:input_5
