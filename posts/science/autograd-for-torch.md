We recently established the Twitter Cortex team with a simple mission: to build a representation layer for Twitter in order to improve our understanding of our content and users.

In pursuing this goal, our biggest challenge is the lack of flexible software. It’s a lengthy process to go from an idea to an algorithm, implementation to training a model on real world data, and then validating the model. Validating an idea can take weeks of programming, debugging, and training. Inspired by [autograd for Python](https://github.com/HIPS/autograd) [1,2], the goal of [autograd for Torch](https://github.com/twitter/torch-autograd/) [3] is to minimize the distance between a new idea and a trained model, completely eliminating the need to write gradients, even for extremely complicated models and loss functions.

If you want to start digging through the project, you can find it at [https://www.github.com/twitter/torch-autograd](https://www.github.com/twitter/torch-autograd). Otherwise, read on for examples of how autograd for Torch makes writing neural networks much simpler and cleaner. To give you a feel for what writing models with autograd looks like, let’s get started with [logistic regression](https://github.com/twitter/torch-autograd/blob/60f025426d5d7576b2f578c920d147c36b09bcb2/examples/train-mnist-logistic.lua).

	-- Import libraries 
	local grad = require 'autograd'
	local util = require 'autograd.util'
	local t = require 'torch'
	 
	-- Load in MNIST (or your favorite dataset)
	local trainData, testData, classes = require('get-mnist.lua')()
	local inputSize = 32*32
	 
	-- Define our neural net
	local function predict(params, input, target)
	   local h1 = input * params.W + params.B
	   local out = util.logSoftMax(h1)
	   return out
	end
	 
	-- Define our loss function
	local function f(params, input, target)
	   local prediction = predict(params, input, target)
	   local loss = grad.loss.logMultinomialLoss(prediction, target)
	   return loss, prediction
	end
	 
	-- Get a function that will automatically compute gradients
	-- of our loss function
	local df = grad(f)
	 
	-- Note: at this point, we’re completely done writing our model.
	-- All gradients will be taken care of automatically.
	 
	-- Define our parameters
	local params = {
	   W = t.FloatTensor(inputSize,table.getn(classes)),
	   B = t.FloatTensor(table.getn(classes))
	}
	 
	-- Now, we can train with e.g. stochastic gradient descent
	for epoch = 1,100 do
	   for i = 1,trainData.size do
	       
	      -- Get a data sample:
	      local x = trainData.x[i]:view(1,inputSize)
	      local y = torch.view(trainData.y[i], 1, 10)
	 
	      -- Calculate gradients (this is the function we defined above,
	      -- and where all of autograd’s magic happens)
	      local grads, loss, prediction = df(params,x,y)
	 
	      -- Update weights and biases
	      params.W = params.W - grads.W * 0.01
	      params.B = params.B - grads.B * 0.01
	 
	    -- That’s it
	   end
	end

Above is a complete example of training logistic regression on MNIST. The only bit we omitted is [how to download the dataset](https://github.com/twitter/torch-autograd/blob/60f025426d5d7576b2f578c920d147c36b09bcb2/examples/get-mnist.lua). You’ll notice that we don’t write or hand-specify gradients. This is the magic of autograd — derivatives are automatically calculated for any Torch function, using an approach called automatic differentiation (often called “AD” or “autodiff”; [here’s a review of AD in machine learning](http://arxiv.org/abs/1502.05767) and a [blog post on why it’s a good idea to use AD](https://justindomke.wordpress.com/2009/02/17/automatic-differentiation-the-most-criminally-underused-tool-in-the-potential-machine-learning-toolbox/)).

Early on, we decided to build our software on top of [Torch](http://torch.ch/) [4], a scientific computing framework with extensive support for machine learning algorithms, built around Lua. One of the main appeals of Torch is its level of customizability and extensibility, and a great hybrid model: write low-level routines in C, CUDA, OpenCL, and abstract everything away with a fast scripting language, Lua. Torch has been widely adopted by the industry.

Since its inception, Torch was built to enable a simple modular approach to machine learning, by providing a library called [nn](https://github.com/torch/nn) [5]. This library lets the user define arbitrary differentiable models, described by assembling primitives into containers. Each primitive must have its gradient explicitly implemented. Describing simple models, like feedforward neural networks, or convolutional neural networks, was always easy, and very efficient in Torch+nn:

	-- define a trainable model, a 2-layer neural network, to classify 100-dim
	-- vectors into 10 categories, using a cross-entropy loss:
	model = nn.Sequential()
	model:add( nn.Linear(100, 200) )
	model:add( nn.Tanh() )
	model:add( nn.Linear(200, 10) )
	loss = nn.CrossEntropyCriterion()
	 
	-- then nn provides methods to compute the gradients. 
	-- First, evaluate the prediction and loss:
	input = torch.randn(1,100)
	target = torch.zeros(1) target[1] = 4
	output = model:forward(input)
	l = loss:forward(output, target)
	 
	-- then evaluate the gradients:
	model:zeroGradParameters()
	dl_doutput = loss:backward(output, target)
	model:backward(input, dl_doutput)
	w,gradw = model:parameters() -- now returns valid gradients wrt w

For more complex graphs, like recurrent networks, the nn container approach can become quite tedious. A library called [nngraph](https://github.com/torch/nngraph) [6] was introduced later, enabling the description of arbitrary graphs of nn primitives. Models described using nngraph are essentially as efficient as those described with nn, which made the framework quite popular for engineers implementing more complex models. It provides the same API, but lets the user connect nn primitives in arbitrary ways:

	-- define trainable nodes:
	input = nn.Identity()()  -- note the double call; this creates an input buffer
	target = nn.Identity()()
	pred = nn.Linear(200,10)( nn.Tanh()( nn.Linear(100,200)( input ) ) )
	loss = nn.CrossEntropyCriterion()({pred, target})
	 
	-- the final model can be declared like this, by declaring the inputs and
	-- outputs:
	model = nn.gModule({input,target}, {loss})
	 
	-- model is a regular nn object, and the same exact API as the model 
	-- defined before, using nn.Sequential()

Torch’s nn package implements a kind of limited automatic differentiation, sacrificing flexibility (you can only use pre-specified modules) for computational efficiency (each module is hand-tuned). Imagine that instead of writing models with only pre-specified modules, you could use any Torch function. We saw in the first example that we can implement logistic regression by directly using elementary operations like * and +. This is inspired by [Python autograd](https://github.com/HIPS/autograd), which lets you write models using plain NumPy arrays and Python operators, and computes the derivatives automatically.

Autograd for Torch [3] takes the best of these two approaches. Very much inspired by Python’s autograd design [1,2], it lets the user express an arbitrary function with Torch tensors and operators, and infers the derivatives automatically. For efficiency, and to build on top of the large body of operators available in nn, it also provides a simple bridge that lets users mix and match both plain Torch functions and use nn modules.

	-- Rewriting the 2-layer neural network above, with the 
	-- cross-entropy loss would look like this (assuming a one-hot encoded target):
	model = function(params, input, target)
	   local h1 = torch.tanh( params.W1 * input + params.b1)
	   local pred = params.W2 * h1 + params.b2
	   local logSoftMaxPred = pred - torch.log(torch.sum(torch.exp(pred)))
	   local loss = - torch.sum(torch.cmul(logSoftMaxPred, target))
	   return loss
	end
	 
	-- not much abstraction, just defining the model as we want it, 
	-- and it’s our responsibility to define trainable parameters:
	params = {
	   W1 = torch.Tensor(200,100),
	   b1 = torch.Tensor(200),
	   W2 = torch.Tensor(10,200),
	   b2 = torch.Tensor(10)
	}
	 
	-- once we’ve defined our parameters, evaluating the loss is just a function 
	-- call:
	loss = model(params, input, target)
	 
	-- time to compute the gradients! 
	d = require ‘autograd’
	grads = d(model)(params, input, target)
	 
	-- If you want to get the gradient and the loss at the same time,
	-- that’s supported transparently
	grads, loss = d(model)(params, input, target)
	 
	-- that’s it, grads is now a table that has the same exact structure as params. 
	-- Autograd only computes derivatives wrt the first argument of the function, 
	-- which can be an arbitrarily nested table of tensors. Any other argument
	-- is used as a constant.

Autograd provides an environment in which any model can be written out, and rely on optimized primitives when necessary. In its most extreme form, autograd can be seen as a replacement for nngraph, where nn primitives can be assembled into any graph, but with one advantage: in autograd, every bit of data (tensor) is a variable that can be used by any function; parameters are treated no differently than hidden or input variables. This simplifies many tasks that were previously extremely complicated such as weight sharing, or attaching a loss to a group of parameters or states. This simplification leads to very rapid prototyping and less debugging.

For example, let’s consider the case of an autoencoder with tied weights between the encoder and decoder. In order to do weight sharing between the encoder and decoder passes with nn, you actually have to reach inside the internals of modules, and hook them up in a “non-standard” way.


	-- This function creates the autoencoder network to make predictions
	-- sizes is a table of layer sizes.
	function makeAutoencoderNN(sizes)
	   local autoencoder = nn.Sequential()
	 
	   -- Encoder
	   local encoder = nn.Sequential()
	   local l1 = nn.Linear(sizes['input'], sizes['h1'])
	   local l2 = nn.Linear(sizes['h1'], sizes['h2'])
	   local l3 = nn.Linear(sizes['h2'], sizes['h3'])
	    
	   encoder:add(l1)
	   encoder:add(nn.Sigmoid())
	   encoder:add(l2)
	   encoder:add(nn.Sigmoid())
	   encoder:add(l3)
	   encoder:add(nn.Sigmoid())
	 
	   -- Decoder
	   local decoder = nn.Sequential()
	   local l4 = nn.Linear(sizes['h3'], sizes['h2'])
	   local l5 = nn.Linear(sizes['h2'], sizes['h1'])
	   local l6 = nn.Linear(sizes['h1'], sizes['input'])
	 
	   -- Tie the weights in the decoding layers
	   l4.weight = l3.weight:t()
	   l4.gradWeight = l3.gradWeight:t()
	   l5.weight = l2.weight:t()
	   l5.gradWeight = l2.gradWeight:t()
	   l6.weight = l1.weight:t()
	   l6.gradWeight = l1.gradWeight:t()
	 
	   decoder:add(l4)
	   decoder:add(nn.Sigmoid())
	   decoder:add(l5)
	   decoder:add(nn.Sigmoid())
	   decoder:add(l6)
	   decoder:add(nn.Sigmoid())
	 
	   autoencoder:add(encoder)
	   autoencoder:add(decoder)
	 
	   return autoencoder
	end
	 
	-- We define autoencoder and criterion modules
	-- so that the final loss function can use them.
	local autoencoder = makeAutoencoderNN(sizes)
	local rCrit = nn.BCECriterion()
	 
	-- This function adds an L2 penalty to the weights of the autoencoder
	-- and computes the total loss and gradient.
	-- Since parameters are treated differently than modules we have
	-- to compute the L2 loss and gradient explicitly.
	function aeLossAndGrad(input, l2Lambda)
	   -- Reconstruction loss
	   -- We need to manually backpropagate from the criterion back through the network.
	   -- This can be made slightly easier with nngraph.
	   local prediction = autoencoder:forward(input)
	   local rLoss = rCrit:forward(prediction, input)
	   rLossGrad = rCrit:backward(prediction, input)
	   autoencoder:backward(input, rLossGrad)
	 
	   -- L2 penalty
	   local l2Penalty = 0
	   -- Since the weights are tied we only need to look at the encoder.
	   -- We apply the L2 penalty to each linear layer of the encoder.
	   -- A memory efficient implementation would have pre-allocated memory
	   -- for intermediate computations.
	   local encoder = autoencoder:get(1)
	   for i=1,encoder:size(),2 do
	      local layer = encoder:get(i)
	      l2Penalty = l2Penalty + l2Lambda * torch.pow(layer.weight, 2):sum()
	      layer.gradWeight:add(layer.weight * 2 * l2Lambda)
	   end
	 
	   local totalLoss = rLoss + l2Penalty
	   local params, dParams = autoencoder:parameters()
	 
	   return dParams, totalLoss, prediction
	end


The first function creates the network and the second function computes the loss and gradient. Notice that for the L2 penalty we have to manually specify the gradient, since we do not get gradients of functions of parameters with nn.

Now we will implement the same model using autograd.

	-- Define the autoencoder with tied weights
	function predict(params, input)
	   -- Encoder
	   local h1 = util.sigmoid(input * params.W[1] + params.B[1])
	   local h2 = util.sigmoid(h1 * params.W[2] + params.B[2])
	   local h3 = util.sigmoid(h2 * params.W[3] + params.B[3])
	 
	   -- Decoder
	   local h4 = util.sigmoid(h3 * torch.t(params.W[3]) + params.B[4])
	   local h5 = util.sigmoid(h4 * torch.t(params.W[2]) + params.B[5])
	   local out = util.sigmoid(h5 * torch.t(params.W[1]) + params.B[6])
	 
	   return out
	end
	 
	-- Define our training loss
	function f(params, input, l2Lambda)
	   -- Reconstruction loss
	   local prediction = predict(params, input)
	   local loss = grad.loss.logBCELoss(prediction, input)
	 
	   -- L2 penalty on the weights
	   for i=1,table.getn(params.W) do
	      loss = loss + l2Lambda * torch.sum(torch.pow(params.W[i],2))
	   end
	 
	   return loss, prediction
	end
	 
	-- Get the gradients closure magically:
	local df = grad(f)

The autograd version is much cleaner and does not rely on manually coded gradients. This example is fairly simple, but the difference would become far more pronounced if we wanted to implement more complicated regularizers and network structures.

Using nn primitives is sometimes quite useful, especially for highly-optimized operations like convolutions, max-pooling, or other operations that are awkward to express as regular Lua code. So how would we define a convolutional network?

	-- autograd wraps nn to re-expose its modules as pure functions. 
	-- First let’s instantiate the modules we need:
	local c1 = d.nn.SpatialConvolutionMM(3,16,5,5)
	local t1 = d.nn.Tanh()
	local m1 = d.nn.SpatialMaxPooling(2,2,2,2)
	local c2 = d.nn.SpatialConvolutionMM(16,32,5,5)
	local t2 = d.nn.Tanh()
	local m2 = d.nn.SpatialMaxPooling(2,2,2,2)
	local r = d.nn.Reshape(13*13*32)
	local l3 = d.nn.Linear(13*13*32,10)
	local lsm = d.nn.LogSoftMax()
	local lossf = d.nn.ClassNLLCriterion()
	 
	-- now we can write our model using the newly created functions:
	model = function(params, x, y)
	   local h1 = m1( t1( c1(x, params.W1, params.b1) ) )
	   local h2 = m2( t2( c2(h1, params.W2, params.b2) ) )
	   local h3 = l3(r(h2), params.W3, params.b3)
	   local yhat = lsm(h3)
	   local loss = lossf(yhat, y)
	   return loss
	end
	 
	-- and again…
	grads = d(model)(params, input, target)

We’ve seen that autograd makes it easy to do some interesting things when defining models. But to be clear, autograd doesn’t enable anything that can’t already be done within nngraph or nn — it’s just a great deal more pleasant to write and a great deal clearer to read.

One area where autograd really shines is in defining your own custom loss functions. Ordinarily, this would require you to define a custom nn module, write down the loss function, derive the gradients by hand, debug the gradients, import the module, then use the loss function. With autograd, all you do is write it down and use it.

	model = function(params, input, target)
	   -- model:
	   local h1 = torch.tanh( params.W1 * input + params.b1)
	   local h2 = params.W2 * h1 + params.b2
	 
	   -- cross-entropy:
	   local logSoftMaxPred = pred - torch.log(torch.sum(torch.exp(pred)))
	   local crossEntropy = - torch.sum(torch.cmul(logSoftMaxPred, target))   
	 
	   -- l2 on states:
	   local states = torch.cat({h1, h2}, 1)
	   local sl2 = torch.sum(torch.cmul(states))
	 
	   -- l2 on weights:
	   local wl2 = torch.sum(torch.cmul(params.W2, params.W2))
	 
	   -- final loss:
	   return loss + sl2 + wl2
	end

This enables extremely rapid prototyping of the entirety of a model, from how input is digested to how the loss is computed. For the Twitter Cortex team, the lowered cost of experimentation has allowed us to design more complicated machine learning models in a significantly shorter amount of time. This flexibility, currently, comes at a slight performance cost: for pure autograd models the slowdown is typically around 2x; for hybrid models where nn is used for the bulk of computations the slowdown is typically under 30%. Thankfully, we’re very optimistic that these differences in efficiency can be reduced and are actively working on further improving autograd to catch up with nn’s runtime.

More significantly, what’s difficult to benchmark is the time it takes to specify a new model and debug it in either nn or autograd. In our hands, autograd has dramatically sped up our model building by making it extremely easy to try and test out new ideas, without worrying about correct gradients, twisting nn to support architectures it wasn’t originally designed for, or having to build new modules or loss functions. Autograd is now the first tool we reach for when building neural networks, and we hope that you enjoy it!

##Acknowledgments
The core work on autograd for Torch was done by [Alex Wiltschko](https://twitter.com/awiltsch), [Clement Farabet](https://twitter.com/clmt), and [Luke Alonso](https://twitter.com/lukedobl). A big thank you to [Kevin Swersky](https://twitter.com/kswersk), [Arjun Maheswaran](https://twitter.com/segmenta), and [Nicolas Koumchatzky](https://twitter.com/nkoumchatzky) for test-driving early beta versions. This project would not have been possible without the original version of autograd for Python, written by Dougal Maclaurin, [David Duvenaud](https://twitter.com/DavidDuvenaud) and Matt Johnson.

##References
[1] Dougal Maclaurin, David Duvenaud, Matt Johnson, “Autograd: Reverse-mode differentiation of native Python”

[2] autograd for Python [https://github.com/HIPS/autograd](https://github.com/HIPS/autograd)

[3] autograd for Torch [https://github.com/twitter/torch-autograd](https://github.com/twitter/torch-autograd)

[4] Torch http://torch.ch , [https://github.com/torch/torch7](https://github.com/torch/torch7)

[5] nn [https://github.com/torch/nn](https://github.com/torch/nn)

[6] nngraph [https://github.com/torch/nngraph](https://github.com/torch/nngraph)

