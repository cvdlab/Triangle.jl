# TRIANGLE.jl

[![Build Status](https://travis-ci.org/cvdlab/TRIANGLE.jl.svg?branch=master)](https://travis-ci.org/cvdlab/TRIANGLE.jl)[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fcvdlab%2FTRIANGLE.jl.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Fcvdlab%2FTRIANGLE.jl?ref=badge_shield)

[![Coverage Status](https://coveralls.io/repos/github/cvdlab/TRIANGLE.jl/badge.svg)](https://coveralls.io/github/cvdlab/TRIANGLE.jl)
[![DOI](https://zenodo.org/badge/doi/10.1007/BFb0014497.svg)](http://dx.doi.org/10.1007/BFb0014497)
[![Read the Docs](https://img.shields.io/readthedocs/pip.svg)](https://cvdlab.github.io/TRIANGLE.jl/)

A Julia interface to Jonathan Richard Shewchuk [Triangle](https://www.cs.cmu.edu/~quake/triangle.html).

### Library notes
At the moment the library will use only CDT, planning to expand later.

### Licensing note

Note that while this binding-library is under a permissive license ([MIT](LICENSE)), the original [Triangle](https://www.cs.cmu.edu/~quake/triangle.html) library isn't:
> Please note that although Triangle is freely available, it is copyrighted by the author and may not be sold or included in commercial products without a license.

So be wary of any possible conflict between your project license and [Triangle](https://www.cs.cmu.edu/~quake/triangle.html)'s


[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fcvdlab%2FTRIANGLE.jl.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Fcvdlab%2FTRIANGLE.jl?ref=badge_large)

## Installing

Just run `Pkg.clone("https://github.com/cvdlab/TRIANGLE.jl.git")` and `Pkg.build("TRIANGLE")`

### Windows

The build proces uses [VC++ for Python](https://www.microsoft.com/en-us/download/details.aspx?id=44266) to build so be sure you have it before running the build part.

## API

Include the module (`using TRIANGLE`).

You can use Julia `?TRIANGLE.methodname` for inline documentation. Documentation can be read on https://cvdlab.github.io/TRIANGLE.jl/ .