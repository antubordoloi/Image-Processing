% Digital Image processing (experiment 9 for rgb images)

clc;
clear all;
close all;
warning off;    %no warning generation

%% reading a RGB image

I=imread('lena_color_256.tif');            %inbuilt matlab image (grayscale
I_size=size(I);                            %size of the image

%% adding noise to the image

I_gaussian=imnoise(I,'gaussian');           %addition of gaussian noise
I_salt=imnoise(I,'salt & pepper');          %addition of salt and pepper noise
I_speckle=imnoise(I,'speckle');             %addition of speckle noise

%% creating low pass filter

I_low_1=fspecial('average', [3,3]);        %low pass filter of size 3X3
I_low_2=fspecial('average', [5,5]);        %low pass filter of size 5X5

%% low pass filtered output for original image

I_1(:,:,1)=imfilter(I(:,:,1),I_low_1);             %filtered output using size of 3X3
I_1(:,:,2)=imfilter(I(:,:,2),I_low_1);
I_1(:,:,3)=imfilter(I(:,:,3),I_low_1);

I_2(:,:,1)=imfilter(I(:,:,1),I_low_2);             %filtered output using size of 5X5
I_2(:,:,2)=imfilter(I(:,:,2),I_low_2);
I_2(:,:,3)=imfilter(I(:,:,3),I_low_2);

%% low pass filtered output

I_lf_1=imfilter(I_gaussian(:,:,1),I_low_1);             %filtered output using size of 3X3
I_lf_2=imfilter(I_gaussian(:,:,2),I_low_1);
I_lf_3=imfilter(I_gaussian(:,:,3),I_low_1);
I_low_filter_1=cat(3,I_lf_1,I_lf_2,I_lf_3);

I_lf_4=imfilter(I_gaussian(:,:,1),I_low_2);             %filtered output using size of 5X5
I_lf_5=imfilter(I_gaussian(:,:,2),I_low_2);
I_lf_6=imfilter(I_gaussian(:,:,3),I_low_2);
I_low_filter_2=cat(3,I_lf_4,I_lf_5,I_lf_6);

I_lf_7=imfilter(I_speckle(:,:,1),I_low_1);              %filtered output using size of 3X3
I_lf_8=imfilter(I_speckle(:,:,2),I_low_1);
I_lf_9=imfilter(I_speckle(:,:,3),I_low_1);
I_low_filter_3=cat(3,I_lf_7,I_lf_8,I_lf_9);

I_lf_10=imfilter(I_speckle(:,:,1),I_low_2);             %filtered output using size of 5X5
I_lf_11=imfilter(I_speckle(:,:,2),I_low_2);
I_lf_12=imfilter(I_speckle(:,:,3),I_low_2);
I_low_filter_4=cat(3,I_lf_10,I_lf_11,I_lf_12);

%% displaying the images

%low filtered (gaussian)
figure;
subplot(221); imshow(I); title('ORIGINAL IMAGE');
subplot(222); imshow(I_gaussian); title('IMAGE HAVING GAUSSIAN NOISE');
subplot(223); imshow(I_low_filter_1); title('3X3 LOW FILTERED IMAGE (GAUSSIAN)');
subplot(224); imshow(I_low_filter_2); title('5X5 LOW FILTERED IMAGE (GAUSSIAN)');

%low filtered (speckle)
figure;
subplot(221); imshow(I); title('ORIGINAL IMAGE');
subplot(222); imshow(I_speckle); title('IMAGE HAVING SPECKLE NOISE');
subplot(223); imshow(I_low_filter_3); title('3X3 LOW FILTERED IMAGE (SPECKLE)');
subplot(224); imshow(I_low_filter_4); title('5X5 LOW FILTERED IMAGE (SPECKLE)');

%% high pass filtered output

I_hf_1=I(:,:,1)-I_1(:,:,1);                         %filtered ouput for size 3X3
I_hf_2=I(:,:,2)-I_1(:,:,2);  
I_hf_3=I(:,:,3)-I_1(:,:,3);  
I_high_filter_1=cat(3,I_hf_1,I_hf_2,I_hf_3);

I_hf_4=I(:,:,1)-I_2(:,:,1);                          %filtered ouput for size 5X5
I_hf_5=I(:,:,2)-I_2(:,:,2);  
I_hf_6=I(:,:,3)-I_2(:,:,3);  
I_high_filter_2=cat(3,I_hf_4,I_hf_5,I_hf_6);

%high filtered 
figure;
subplot(131); imshow(I); title('ORIGINAL IMAGE');
subplot(132); imshow(I_high_filter_1); title('3X3 HIGH FILTERED IMAGE');
subplot(133); imshow(I_high_filter_2); title('5X5 HIGH FILTERED IMAGE');

%% median filtering (removal of salt and pepper noise)

I_med(:,:,1)=medfilt2(I_salt(:,:,1),[3,3]);                          %filtered output 3X3
I_med(:,:,2)=medfilt2(I_salt(:,:,2),[3,3]);                          
I_med(:,:,3)=medfilt2(I_salt(:,:,3),[3,3]);

I_med2(:,:,1)=medfilt2(I_salt(:,:,1),[5,5]);                         %filtered output 5X5
I_med2(:,:,2)=medfilt2(I_salt(:,:,2),[5,5]);                          
I_med2(:,:,3)=medfilt2(I_salt(:,:,3),[5,5]);

%% high boost filtered image

A=1.5;
I_high_boost(:,:,1)=A*I(:,:,1)-I_1(:,:,1);          %filtered image 3X3
I_high_boost(:,:,2)=A*I(:,:,2)-I_1(:,:,2);                          
I_high_boost(:,:,3)=A*I(:,:,3)-I_1(:,:,3);                          

I_high_boost2(:,:,1)=A*I(:,:,1)-I_2(:,:,1);          %filtered image 5X5
I_high_boost2(:,:,2)=A*I(:,:,2)-I_2(:,:,2);                          
I_high_boost2(:,:,3)=A*I(:,:,3)-I_2(:,:,3); 

%% displaying the images

%median filtered image
figure;
subplot(221); imshow(I); title('ORIGINAL IMAGE');
subplot(222); imshow(I_salt); title('IMAGE HAVING SALT AND PEPPER NOISE');
subplot(223); imshow(I_med); title('MEDIAN FILTERED IMAGE (3X3)');
subplot(224); imshow(I_med2); title('MEDIAN FILTERED IMAGE (5X5)');

%high boost filtering
figure;
subplot(131); imshow(I); title('ORIGINAL IMAGE');
subplot(132); imshow(I_high_boost); title('HIGH BOOST FILTERED IMAGE (3X3)');
subplot(133); imshow(I_high_boost2); title('HIGH BOOST FILTERED IMAGE (5X5)');
