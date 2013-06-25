# Re-Collect Wiring Notes

## Lights

### External ports

The lighting box contains 30 light sources:

* 25 2.1 mm port on the front
* 5 high power light outputs on the back (for optic fibers)

The _logic_ numbering of the light sources is as follows (this should become a drawing),
counting from the top-left corner facing the front of the box:

* Cluster 1
    * **0-4** Front
    * **5** Back
* Cluster 2
    * **6-10** Front
    * **11** Back
* Cluster 3
    * **12-16** Front
    * **17** Back
* Cluster 4
    * **18-22** Front
    * **23** Back
* Cluster 5
    * **24-28** Front
    * **29** Back

The numbers correspond to the LED index in the table of 30 values sent to the box from PureData. The logic numbering thus groups each cluster into a contiguous block as seen from the PureData software.

### Internal connectors

**FIXME:**

* Write a mapping from port number on the front to individual connectors on the TLC boards
* Write a mapping from the ZXLD driver outputs to the individial, numbered high-power LEDs on the back.
* Draw a diagram of the misc bus connections between the electronics boards
