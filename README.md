# Mutation analysis of Jsoup project

## Jsoup as target of analysis
### about the project
Jsoup is a Java library for working with real-world HTML. It provides a very convenient API for extracting and manipulating data, using the best of DOM, CSS, and jquery-like methods. It's authored by Jonathan Hedley, a software development manager for Amazon Seattle, and distributed under the open source MIT license. Here's the jsoup's [website](http://jsoup.org/) and [github page](https://github.com/jhy/jsoup).

### Source code and build environment
Jsoup had 6120 lines of Java code for testing purposes and 18709 lines of Java code for functionality at the time of this analysis. The test suit uses JUnit with ant integration and analysis is done in Ubuntu 14.04 system.

## Running Major with the jsoup
### Tests and mutations
The project had 469 tests in total. With `all.mml`, there are 6684 mutants generated. It took roughlt 3 hours for my laptop to finish the mutation analysis for the project.

### Repreduce the analysis results
I have extracted the `build.xml` and `maven-build.xml` with command `mvn ant:ant`, and modified `build.xml` to use configure Major into it. You can reproduce the full mutation analysis result by executed shell script `run.sh`. Alternatively, you may execute `smallSampleRun.sh`, to only introduce small amount of mutants, with smaller.mml file, to get a quick result.

### About files generated
Here are a list of files generated by the run:
* **mutants.log** contains one line for each generated mutant. Each line contains the type of mutation, the method and line of the mutation, and the actual syntactic mutation applied.
* **killed.csv** contains a line for each generated mutant. Each line identifies the mutant ID from mutants.log and the status of the mutant at the end of analysis. FAIL, TIME, and EXC mean that the mutant was killed by an assertion failure, test timeout, or an exception. LIVE means that the mutant was still live at the end of analysis.
* **results.csv** contains the mutation analysis for each individual test in the test suite.
* **testMap.csv** contains mapping of test number shown in result.csv and test name.
* **summary.csv** contains the complete mutation analysis results. 
* **stdout.log** contains logs written to stdout in the during the run.
* **testMap.csv**
* **target** complied *.class files for the project

## Analysis of the result
### Result in numbers
* The number of mutants generated = **6684**
* The number of mutants covered by the test suite = **5398** (80.76% of generate)
* The number of mutants killed by the test suite = **3588**
* The number of live mutants = **1810**
* The overall mutation score(kill/generated) / adequacy of the test suite(killed/covered) = **53.68% (66.47%)**

The result shows that `killed + live = covered`.Covered means a mutant occured in a line that is covered by the unit test. If the unit test does not even execute that line, then the test suit definitely cannot kill that mutant. On the other hand, if a mutant is covered, the test suite might or might not kill the mutant, corresponding to LIVE/KILLED result for that mutant.


What do the results tell you about your test suite? Does the test suite exhibit weaknesses? How can it be improved? Does the test suite exhibit strengths? How do you recognize them?
The coverage score (80.76%) shows almost 20% of the code are not covered by any test case. This means whatever bug introduced to that part will not be detected by the test suite. This means tests cases need to be added to the test suite to cover the one fifth of the code base.
The kill/covered(66.47%) score shows how good is the test suite on detecting a bug introduced in the covered code base. The scores indicates that test cases needs to be improved to provide better capability to detect bug.

### Reflections
The mutation analysis showed the quality of the test suite. On the upside, I was able to integrate the tool (Major) with a project exited for sometime in a short time. On the downside, each run of the analysis tooks far more time than unit testing, making it not suitable for continious integration. 

For someone who has never used Maven, ant nor JUnit, let alone Major, the process was fairly smooth. A major obstacle was to modify the `build.xml` file. I overcame it by learning from the sample file and online documentations.
