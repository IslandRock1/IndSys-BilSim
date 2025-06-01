# IndSys-BilSim

Car simulation platform aimed at development, and educational applications. Its is built using CODESYS running on WAGO PLC hardware, with a visualization layer provided by Gedot. The simulator uze to control and monitor three MAC 800 motors using EtherCAT communication.

## Features

- **CODESYS-based Automation:** Developed for WAGO PLCs in CODESYS.
- **Gedot Visualization:** Real-time monitoring.
- **EtherCAT Communication:** Controls three MAC 800 motors with Ethercat.
- **Security Functions:** Ensures safe operation and access control.
- **Calibration Utilities:** Tools for precise setup and adjustment of motors using limit switches.


## System Architecture

- **PLC Platform:** WAGO (CODESYS compatible)
- **Motors:** 3 × MAC 800 (EtherCAT)
- **HMI(Bejer):** 
- **Visualization:** Godot, Beijer, and Codesys

## Installation & Setup

1. **Clone or Download the Project**
    ```bash
    git clone https://github.com/IslandRock1/IndSys-BilSim.git
    ```

2. **Open in CODESYS**
   - Launch CODESYS on your development PC.
   - Open the project file from the repository.

3. **Configure Hardware**
   - Ensure your WAGO PLC is set up for EtherCAT.
   - Connect three MAC 800 motors to the EtherCAT bus.

4. **Deploy to PLC**
   - Download the project onto the target WAGO PLC.
   - Follow the security and calibration procedures as described in the documentation or HMI.

5. **Run Gedot Visualization**
   - Open the Gedot visualization project.
   - Connect to the PLC to monitor and control the simulation.

## Usage

- Use the Gedot interface for real-time monitoring, control, and calibration.
- Access security functions to manage user permissions and safe states.
- Calibrate motors as needed using provided tools or visualization interface.
