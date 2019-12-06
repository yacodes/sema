
trainingInput = []
trainingOutput = []
_____
target = 1
recording=0
____
trainingInput
trainingOutput[400]

____

______

onMouseMove = (x,y) =>{if (recording) {console.log(y);
                                       trainingInput[trainingInput.length] = x;
                                       trainingInput[trainingInput.length] = y;
                                      trainingOutput[trainingOutput.length] = target};}
______
//js

//create the model
var model = tf.sequential();
model.add(tf.layers.dense({ units: 1, inputShape: [2] }));
model.compile({ loss: 'meanSquaredError', optimizer: 'sgd' });

//set up the training data set
xs = tf.tensor2d(trainingInput, [trainingInput.length/2,2]);
ys = tf.tensor2d(trainingOutput, [trainingOutput.length,1]);
//var xs = tf.tensor2d([0, 1, 2, 3, 4, 5], [6, 1]);
//var ys = tf.tensor2d([0, 50, 100, 150, 200, 250], [6, 1]);

//train the model on the data set
trainingRecord =0;
model.fit(xs, ys, { epochs: 500 }).then(result => {console.log(`Model trained`); console.log(result); trainingRecord = result;});
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
networkOutput = [0];
onMouseMove = (x,y) =>{if (predicting) {networkOutput = test([x,y]);
                                        console.log(networkOutput);
                                       }}

__________
//route the model predictions back to the live coding environment
output = (x) => {console.log(networkOutput[0]);return networkOutput[0];}

____


__________

//route the test data into the model
var w = 0;
input = (id,x) => {console.log(">toModel:   "+[id,x]); w=x};


____

tf.ones([2, 5]).dataSync()
