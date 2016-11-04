---
layout: page
title: #HackingGreat 3 @ Cybercom - Tech Track 3 - The Communist AI
---

## Tech Track 3 - The Communist AI

Download the [corpus8k.wav](https://drive.google.com/file/d/0B7ED5AY6wP1CcjR4U2pYTVlaOTg/view?usp=sharing) to the `corpus` directory. You only need it if you want to try training the network.
Note that training the network takes weeks, but you can try it anyhow.

The pre-trained model was trained on 48 kHz corpus. The sound model is snapshotted to 

If you want the better quality corpus, in 48k sample rate, there is [corpus.wav](https://drive.google.com/file/d/0B7ED5AY6wP1Cd1prV0N6SGhxZ0E/view?usp=sharing) also. Note that training that requires several months.
It's also quite large, almost 1 GB.

The `corpus` directory contains two files (after you downloaded the `corpus.wav`):

 * `corpus8k.wav`: approximately 1.5 hours of Communist music concatenated to a single channel 8 kHz WAV file.
 * `test8k.wav`: A Communist music piece not included in the corpus for use as a test example.

Validation set is skipped, as the real validation happens in generating sounds with the system.

![Process](https://cybercom-finland.github.io/hacking-great-3/t3-communist-ai/images/process.png "Process")

* [Some intermediate results](https://www.youtube.com/watch?v=kf2yrSmh3zw)

## The Model

The model used is a WaveNet with a receptive field size of 4093 samples. In 48 kHz wave it corresponds to 0.085 seconds of audio. It has a stack of four ten-layer exponential (1, 2, 4, 8, ..., 512) stride atrous convolutional layers.

## Caveat

Training such large models will take 1-2 months using decent consumer grade hardware. Because of this, we weren't
able to have a very well trained final model, but we will have some model that probably leans towards Leninism a bit
even though it is not yet completely brainwashed yet.

Joking aside, the technical side in training these models is that the model learns a decent prediction model
pretty fast and gets decent loss values and 1-step forward outputs for training inputs. However, the network
has a lot of uncertainty at occasional situations leading to snapping sounds in generation. That is because
the model output gives a somewhat uniform distribution of amplitude values when uncertain. Sometimes these
lead to snaps when in generation a somewhat improbable outlier is selected.

Additionally in generation is is important that the model has totally saturated its internal representation
probability distributions so that it does not have large volumes of value space dedicated to situations that
do not match training data. This is because in generation the uncertainty accumulates quickly, and a small
divergence in the generated output that is not exactly something seen in the training data is not generalized
well by the model when fed back to the input, causing internal representations in non-training space volume,
and this causes noise in the output, because the output neurons haven't seen such internal representations in
training and their respective output is pretty much undefined. So, for not completely trained models
the generated output is colored noise that has some amplitude envelope structure.

Deep learning is like pulled pork. You have to cook it for a long time.

After about 2 weeks of cooking (training) on an i5-4690 CPU @ 3.50GHz with 24 GB of memory (Note that the model is too large for any consumer grade GPU system) we got something like this: [generated.wav](https://github.com/cybercom-finland/hacking-great-3/raw/master/t3-communist-ai/samples/generated.wav). Possibly before the event the quality is a bit better, but not much.

### Training

You can well skip this step, as it takes a really long time (months) to properly train this kind of model. But you can kind of try it out and see where it is going.
Intermediate results are interesting to look at and play with also, even if they are very noisy. Not fully trained models cannot be used very effectively for generating
waveforms, as the results are pretty much noise.

NOTE: Training takes a lot of memory, so for a normal laptop it is quite probable that swapping will occur and
the machine freezes totally. It is recommended to turn off swap for such workloads. Regardless the training
is so resource intensive that it will likely prevent all other use of the computer.

You can train a model using a command `python process.py --model sound-model`. The --model parameter is
optional, and specifies the starting point for training. Check also the parameters for the model
in the file `params.py`.

The repository will contain a pre-trained model, so you can skip this step.

Training the model well (over 3 weeks on decent hardware) the results will look like something like this
plotting the resultant data in Octave
using the `plot_training.m` Octave script.

![Training](https://cybercom-finland.github.io/hacking-great-3/t3-communist-ai/images/training.png "Training")

The trained model snapshots are stored to `sound-model` and `sound-model.meta` files. For convenience,
the model that achieved the best test accuracy against the test input/output pair is stored in the `sound-model-best` and `sound-model-best.meta`.

### Generating Wave Forms

The waveforms are generated by feeding the trained model a seed wave. The system then tries to predict the next sample, or more accurately it predicts the discrete distribution
in 256-valued µ-law encoding for the next sample. The system then picks a value from this predicted distribution, and it is added to the end of the seed wave.
Then this is repeated, and the system generates a sound wave based on the initial seed.

It takes a long time (several hours or so) to get reasonably long wave forms, but intermediate results can be interesting to look at.

You can generate a sound sample using a command `python generate.py`. Check also the parameters for the model
in the file `params.py`. Note that in generation the model related parameters need to be identical to the parameters of the trained model for the snapshot restoration to work. You can play with the temperature parameter freely.

The repository will contain a set of pre-generated waveforms for different seed signals and temperatures, so you can skip this step.

Generating a few steps of a sample will look like something like this plotting the resultant data in Octave
using the `plot_generation.m` Octave script.

![Generation](https://cybercom-finland.github.io/hacking-great-3/t3-communist-ai/images/generation.png "Generation")

You can also skip this step if you want and do other things. There are some generated example outputs in the `samples` directory for different values of temperature. For example filename `0_95.wav` means a temperature
0.95 was used in the generation. `1_0_2.wav`means this is the second example of generation using temperature of 1.0.

Temperature 1.0 means using the estimated probability distribution as is in the generation. Lower temperature means weighting the most likely options more, avoiding the less likely alternatives. Higher temperature means giving less weight for the most likely option, and weighting
the less likely options more. The order of likelihood does not change between the options, only relative weighting.


## Corpus Sources Used

 * Test sample: [Arja Saijonmaa - Komintern](https://www.youtube.com/watch?v=0-1XOa8_8GQ)
 * [Arja Saijonmaa - Taistojen tiellä](https://www.youtube.com/watch?v=4Bb8o6ECKEs)
 * [Barrikadimarssi](https://www.youtube.com/watch?v=3oXNs5sP_T4)
 * [Kansainvälinen](https://www.youtube.com/watch?v=xW9VBLH-0_s)
 * [Kenen joukoissa seisot - (Kom Teatteri)](https://www.youtube.com/watch?v=qJjaIG4lhCs)
 * [Kolme pikku miestä](https://www.youtube.com/watch?v=-mWtwoWB3XI)
 * [Köyhälistön marssi](https://www.youtube.com/watch?v=shJm-l3c54s)
 * [Kulttuuritalon kuoro - Kansainvälinen](https://www.youtube.com/watch?v=pbLP-stgog0)
 * [Lenin-setä asuu Venäjällä](https://www.youtube.com/watch?v=XjVnbVStaDA)
 * [Liisa Tavi - Lukevan työläisen kysymyksiä](https://www.youtube.com/watch?v=A5ipCT9w940)
 * [Nuorison marssi](https://www.youtube.com/watch?v=7V21y_G8EQU)
 * [Punaorvon vala - (Kom Teatteri)](https://www.youtube.com/watch?v=F1UX6UlHnBY)
 * [Red Army Choir ~ Internationale](https://www.youtube.com/watch?v=nMpmCHnRjNQ)
 * [Riistäjän lait - (Kom Teatteri)](https://www.youtube.com/watch?v=GsF_6UmEuY4)
 * [Savolainen Balladi](https://www.youtube.com/watch?v=Bgpt94GWjXE)
 * [Toveri mitä odotat - (Kom Teatteri)](https://www.youtube.com/watch?v=YPBpioBZg1s)
 * [Vapun soittolista 2016 Lauluja kansojen taistelusta](https://www.youtube.com/watch?v=sZbyFUeFjoQ)
 * [Veli sisko](https://www.youtube.com/watch?v=OHWJr2qnZX8)

## See Also
 * Examples of sound generation using different temperatures in generation: [tensorflow-wavenet-temperature-demo](https://soundcloud.com/robinsloan/sets/tensorflow-wavenet-temperature-demo)
 * A nice implementation of WaveNet in TensorFlow: [TensorFlow WaveNet](https://github.com/ibab/tensorflow-wavenet)

## Compulsory Copyright Notice

All sound content belongs to their respective copyright holders. The concatenated WAV file is meant for academic research / teaching only on the basis of the respective
[copyright exceptions in the Finnish copyright law](http://www.finlex.fi/fi/laki/ajantasa/1961/19610404#L2P14), American fair use and also noting that the property of a Communist is common.
