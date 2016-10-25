---
layout: page
title: #HackingGreat 3 @ Cybercom
---

# \#HackingGreat 3 @ Cybercom

Pre-requisite information and code for the #HackingGreat sauna evening by Cybercom.

Time and place: 2016-11-10, 16:00–, [Technopolis, Kansleri](http://www.technopolis.fi/kokoustilat/tampere/yliopistonrinne/kalevantie-2-kansleri/)

Meetup for registration: [https://www.meetup.com/HackingGreat-Cybercom/events/234416242/](https://www.meetup.com/HackingGreat-Cybercom/events/234416242/)

Collaborative Spotify playlist: 
[http://open.spotify.com/user/cybercomfinland/playlist/3UjTaopdGCr4xc8TWUWKJH](http://open.spotify.com/user/cybercomfinland/playlist/3UjTaopdGCr4xc8TWUWKJH)
(Using your own account, click "follow", and then you can add songs to the playlist)

Get the code \([https://github.com/cybercom-finland/hacking-great-3](https://github.com/cybercom-finland/hacking-great-3)\) before the event using: `git clone https://github.com/cybercom-finland/hacking-great-3`

Bring your own laptop with preferably Linux! Other operating systems can be made to work, but that is more work for you.

![Our walker, Pertti](https://pbs.twimg.com/media/CQKs2NtUAAA7XrZ.jpg:medium "Our walker, Pertti")

---

## Tech Track 1: Docker on Cloud Platforms by Dockerist Toni Ylenius

Play with a pipeline where tools like docker, swarm mode, openshift, AWS, terraform are involved. To get started there is a trivial web application to play with.

* [Instructions here!](https://cybercom-finland.github.io/hacking-great-3/t1-docker/)

### Prerequisites and tools:
* Prefereably a Linux laptop with Docker already intalled
* See also the instructions in Tech Track 4

---

## Tech Track 2: Physical UI with Light Button Launchpads by Buttonist Rolf Koski

We will provide two, or hopefully three launchpad minis to play with during the session.

See: [https://us.novationmusic.com/launch/launchpad](https://us.novationmusic.com/launch/launchpad)

* [Instructions here!](https://cybercom-finland.github.io/hacking-great-3/t2-launchpad/)

### Prerequisites and tools:
* install https://www.npmjs.com/package/util
* install https://www.npmjs.com/package/events
* install https://www.npmjs.com/package/midi

---

## Tech Track 3: Tensorflow with WaveNet and Communism by The Mad Machine Learning Scientist Tero Keski-Valkama
We will check out a pre-trained [WaveNet](https://deepmind.com/blog/wavenet-generative-model-raw-audio/) network that has been fed hundreds of hours of Communist songs.
This is interrogated to make music to our ears.
The pre-requisite project is still work in progress, coming together here: [https://github.com/keskival/wavenet_synth](https://github.com/keskival/wavenet_synth).
Don't worry, we will add the cleaned up final code to this repo well before the event, alongside with the corpus data, the pre-trained network and instructions.

* [Instructions here!](https://cybercom-finland.github.io/hacking-great-3/t3-communist-ai/)

### Prerequisites and tools:
* Install [Octave](https://www.gnu.org/software/octave/).
* Install [TensorFlow](https://www.tensorflow.org/versions/r0.11/get_started/os_setup.html), the CPU version, because GPUs do not have enough memory for this purpose and do not give performance improvement. If you install the GPU version, that is fine, but you probably need to disable the GPU acceleration by using `export CUDA_VISIBLE_DEVICES=-1`
* Read about [WaveNet](https://deepmind.com/blog/wavenet-generative-model-raw-audio/), check out the examples.

---

## Tech Track 4: ELK Stack with Docker / Docker Compose by Yet Another Dockerist Jouni Mykkänen
Data source for the other tracks.
Learn a quick setup for ELK stack, import your data and visualize it.

### Prerequisites and tools:
* ...

---

## Tools common for all the tracks:
* Your own laptop, preferrably Linux
* Code \([https://github.com/cybercom-finland/hacking-great-3](https://github.com/cybercom-finland/hacking-great-3)\), using: `git clone https://github.com/cybercom-finland/hacking-great-3`
* An IDE, for example:
  * Eclipse ([https://eclipse.org/](https://eclipse.org/)
  * Atom ([https://atom.io/](https://atom.io/))
  * WebStorm ([https://www.jetbrains.com/webstorm/](https://www.jetbrains.com/webstorm/))
  * or maybe even all of them.
