# extract_bg_16high.py

with open('levels/level_data/stereomadness_bg.bin', 'rb') as f:
    data = f.read()

out = b''.join(
    data[y * 894:(y + 1) * 894]
    for y in range(11, 27)
)

with open('levels/level_data/stereomadness_16high.bin', 'wb') as f:
    f.write(out)

print('Size:', len(out), 'bytes')