function [BW,maskedImage] = createMask_4PNG(RGB)
%segmentImage Segment image using auto-generated code from imageSegmenter app
%  [BW,MASKEDIMAGE] = segmentImage(RGB) segments image RGB using
%  auto-generated code from the imageSegmenter app. The final segmentation
%  is returned in BW, and a masked image is returned in MASKEDIMAGE.

% Auto-generated by imageSegmenter app on 14-Feb-2019
%----------------------------------------------------


% Convert RGB image into L*a*b* color space.
X = rgb2lab(RGB);

% Graph cut
foregroundInd = [387826 444203 544588 845692 872612 879953 894635 965621 980306 1002338 1039058 1159010 1274066 1345058 1416050 1516418 1668194 1739186 1810178 1861586 1873823 1932569 1996209 2040270 2059854 5979108 6236142 6365886 6436878 6544590 6666990 6772254 6958302 7144350 7203102 7230030 7237374 7296123 7359765 7445442 7509090 7538466 7560495 7575180 7582524 7587341 7587344 7587350 7587414 7594697 7594709 7594723 7594750 ];
backgroundInd = [1103501 3377038 3763758 3962014 4133351 4270409 4277753 4370766 4456440 4542114 4649826 4835874 4857909 5129660 5514046 5572807 5864195 6202162 6701726 7218356 7409312 7431344 7546391 7639389 7695658 7739693 7761295 7761313 7761328 7761348 7761371 7761395 7766180 7766314 7773509 7773930 7780841 7780847 7781031 7788168 7788174 7810445 7810606 7817915 7825165 7825198 7825230 ];
L = superpixels(X,40051,'IsInputLab',true);

% Convert L*a*b* range to [0 1]
scaledX = prepLab(X);
BW = lazysnapping(scaledX,L,foregroundInd,backgroundInd);

% Create masked image.
maskedImage = RGB;
maskedImage(repmat(~BW,[1 1 3])) = 0;
end

function out = prepLab(in)

% Convert L*a*b* image to range [0,1]
out = in;
out(:,:,1)   = in(:,:,1) / 100;  % L range is [0 100].
out(:,:,2:3) = (in(:,:,2:3) + 100) / 200;  % a* and b* range is [-100,100].

end
