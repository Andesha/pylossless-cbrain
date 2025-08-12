# pylossless-cbrain

This repository contains the build and test information for the pyLossless port for CBRAIN.

## Container Building Instructions

```bash
git clone https://github.com/Andesha/pylossless-cbrain.git
cd pylossless-cbrain
docker build --no-cache -t base-pylossless .
docker run -v ./input_test:/input -v ./output_test:/output -td --name pylossless base-pylossless
docker exec -it pylossless bash
```

### Run a Test

Assuming you are inside the previously built container:

```bash
python3 main.py /input/IC_trn_P01_F_1.bdf
```

Output will be written to the `output_test` directory in the git repository assuming you have used the same mounts.

## Disclaimers

Currently the launching point of the container only implements processing a single BDF file and writing the output as BIDS derivative. More input file options will be made available upon completed testing.

### Further test commands

```bash
tyler@theralion:~/Documents/eeg-dev/pylossless-cbrain$ docker run -v ./input_test:/input -v ./output_test:/output -it --entrypoint bash base-pylossless /input/IC_trn_P01_F_1.bdf 123 123
```