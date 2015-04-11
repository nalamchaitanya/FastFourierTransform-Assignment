

gcc ./src/generateSignalArr.c -lm -o ./bin/generateSignalArr
gcc ./src/zeroCrossing.c -lm -o ./bin/zeroCrossing
gcc ./src/peakLocation.c -lm -o ./bin/peakLocation
gcc ./src/superPosition.c -lm -o ./bin/superPosition
gcc ./src/generateSignalXY.c -lm -o ./bin/generateSignalXY
gcc ./src/convolution.c -lm -o ./bin/convolution

cd bin
let "s = 1024"
for f in 50 100 150 200
do
	for r in {0..1000..10}
	do
		./generateSignalArr $f $r 1 $s sin_F${f}_R${r}.txt
		./zeroCrossing sin_F${f}_R${r}.txt $f $r $s error_F${f}.txt
		rm sin_F${f}_R${r}.txt
	done
	echo "set terminal 'jpeg'" >> plot.txt
	echo "set output 'error_F${f}_1A.jpeg'" >> plot.txt
	echo "plot 'error_F${f}.txt' with linespoints" >> plot.txt
	gnuplot < plot.txt
	rm plot.txt
	rm error_F${f}.txt
done
cd ..
echo "Part a of Question 1 is completed."

cd bin
let "k = 10"
for f in 50 100 150
do
	for s in 1024
	do	
		for r in {0..1000..10}
		do
			./generateSignalArr $f $r 1 $s sin_F${f}_S${s}_R${r}.txt
			./ComputeFFT sin_F${f}_S${s}_R${r}.txt $k $s sin_F${f}_S${s}_R${r}_FFT.txt
			./peakLocation sin_F${f}_S${s}_R${r}_FFT.txt $f $r $s error_F${f}_S${s}_1B.txt
			#echo "set terminal 'jpeg'" >> plot.txt
			#echo "set output 'sin_F${f}_S${s}_R${r}_FFT.jpeg'" >> plot.txt
			#echo "plot 'sin_F${f}_S${s}_R${r}_FFT.txt' with linespoints" >> plot.txt
			#gnuplot < plot.txt
			#rm plot.txt
			rm sin_F${f}_S${s}_R${r}.txt
			rm sin_F${f}_S${s}_R${r}_FFT.txt
		done
		echo "set terminal 'jpeg'" >> plot.txt
		echo "set output 'error_F${f}_S${s}_1B.jpeg'" >> plot.txt
		echo "plot 'error_F${f}_S${s}_1B.txt' with linespoints" >> plot.txt
		gnuplot < plot.txt
		rm plot.txt
		rm error_F${f}_S${s}_1B.txt
	done
done
cd ..
echo "Part b of Question 1 is completed."

cd bin
for f1 in 50 150 250
do
	./generateSignalArr ${f1} 1000 1 1024 sin_F${f1}.txt
	for f2 in 100 200 300
	do
		./generateSignalArr ${f2} 1000 1 1024 sin_F${f2}.txt
		./superPosition sin_F${f1}.txt sin_F${f2}.txt sin_F${f1}_F${f2}.txt
		./ComputeFFT sin_F${f1}_F${f2}.txt 10 1024 sin_F${f1}_F${f2}_FFT.txt
		echo "set terminal 'jpeg'" >> plot.txt
		echo "set output 'sin_F${f1}_F${f2}_FFT_2A.jpeg'" >> plot.txt
		echo "plot 'sin_F${f1}_F${f2}_FFT.txt' with linespoints" >> plot.txt
		gnuplot < plot.txt
		rm plot.txt
		rm sin_F${f2}.txt
		rm sin_F${f1}_F${f2}.txt
		rm sin_F${f1}_F${f2}_FFT.txt
	done
	rm sin_F${f1}.txt
done
cd ..
echo "Part a of Question 2 is completed."

cd bin
for f1 in 50 150 250
do
	./generateSignalArr ${f1} 1000 1 1024 sin_F${f1}.txt
	for f2 in 100 200 300
	do
		./generateSignalArr ${f2} 1000 1 1024 sin_F${f2}.txt
		./convolution sin_F${f1}.txt 1024 sin_F${f2}.txt 1024 sin_F${f1}_F${f2}.txt
		./ComputeFFT sin_F${f1}_F${f2}.txt 10 1024 sin_F${f1}_F${f2}_FFT.txt
		echo "set terminal 'jpeg'" >> plot.txt
		echo "set output 'sin_F${f1}_F${f2}_FFT_2B.jpeg'" >> plot.txt
		echo "plot 'sin_F${f1}_F${f2}_FFT.txt' with linespoints" >> plot.txt
		gnuplot < plot.txt
		rm plot.txt
		rm sin_F${f2}.txt
		rm sin_F${f1}_F${f2}.txt
		rm sin_F${f1}_F${f2}_FFT.txt
	done
	rm sin_F${f1}.txt
done
cd ..
echo "Part b of Question 2 is completed."


cd bin
for s in 32 1024 32768
do
	for f1 in 50
	do
		./generateSignalArr ${f1} 1000 1 $s sin_F${f1}_S${s}.txt
		for f2 in 100
		do
			./generateSignalArr ${f2} 1000 1 $s sin_F${f2}_S${s}.txt
			./convolution sin_F${f1}_S${s}.txt $s sin_F${f2}_S${s}.txt $s sin_F${f1}_F${f2}_S${s}.txt
			./ComputeFFT sin_F${f1}_F${f2}_S${s}.txt 10 $s sin_F${f1}_F${f2}_S${s}_FFT.txt
			echo "set terminal 'jpeg'" >> plot.txt
			echo "set output 'sin_F${f1}_F${f2}_S${s}_FFT_2C.jpeg'" >> plot.txt
			echo "plot 'sin_F${f1}_F${f2}_S${s}_FFT.txt' with linespoints" >> plot.txt
			gnuplot < plot.txt
			rm plot.txt
			rm sin_F${f2}_S${s}.txt
			rm sin_F${f1}_F${f2}_S${s}.txt
			rm sin_F${f1}_F${f2}_S${s}_FFT.txt
		done
		rm sin_F${f1}_S${s}.txt
	done
done
cd ..
echo "Part c of Question 2 is completed."


mv ./bin/*1A.jpeg graphs1A
mv ./bin/*2A.jpeg graphs2A
mv ./bin/*1B.jpeg graphs1B
mv ./bin/*2B.jpeg graphs2B
mv ./bin/*2C.jpeg graphs2C