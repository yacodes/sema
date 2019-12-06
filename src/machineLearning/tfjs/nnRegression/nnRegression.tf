//js
trainingInput = []
trainingOutput = []
_____
target = [0]
recording = 0
______

onMouseMove = (x,y) => {
  if (recording) {
    console.log(y);
    trainingInput = trainingInput.concat([x,y]);
    trainingOutput = trainingOutput.concat(target)
  };
}
______


//create the model
var model = tf.sequential();
model.add(tf.layers.dense({ units: target.length, inputShape: [2] }));
model.compile({ loss: 'meanSquaredError', optimizer: 'sgd' });

//set up the training data set
xs = tf.tensor2d(trainingInput, [trainingInput.length/2,2]);
ys = tf.tensor2d(trainingOutput, [trainingOutput.length / target.length, target.length]);

//train the model on the data set
trainingRecord =0;
model.fit(xs, ys, { epochs: 500 })
.then(result => {
                  console.log(`Model trained`);
                  console.log(result);
                  trainingRecord = result;
                });
_____

trainingRecord.history.loss
_____
//defining the callback for testing the model on new data
var test = (x) => { return model.predict(tf.tensor2d([x], [1, 2])).dataSync(); }

____
test([trainingInput[200], trainingInput[201]])
_____
test([0.9,0.1])

___

predicting=1;
networkOutput = target;
onMouseMove = (x,y) => {
  if (predicting) {
    networkOutput = test([x,y]);
    console.log(networkOutput);
  }
}

__________
//route the model predictions back to the live coding environment
output = (x) => {console.log(networkOutput[x]);return networkOutput[x];}

____
