import pylossless as ll
import mne
import mne_bids
import sys

subject_file = sys.argv[1]
subject_id = '001'

raw = mne.io.read_raw_bdf(subject_file, preload=True)

# Trim for testing
raw = raw.crop(tmin=0.0, tmax=100.0)

pipeline = ll.LosslessPipeline('lossless.yaml')
pipeline.run_with_raw(raw)

# Save
bids_path = mne_bids.BIDSPath(subject=subject_id, task='test', suffix='eeg', extension='.edf', datatype='eeg', root=sys.argv[2])
pipeline.save(pipeline.get_derivative_path(bids_path), overwrite=True)
