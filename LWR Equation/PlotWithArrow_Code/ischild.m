function isc = ischild(hc,hp)
% isc = ischild(hc,hp)
% �жϾ��hc�ǲ���hp���Ӷ���
% ��ȡ����Matlab/Simulinkԭ�����Ϻͳ������ע΢�Ź��ںţ�Matlab Fans

hc_list = allchild(hp);
% isc = any( arrayfun( @(x) x == hc , hc_list ) );   % ����ֱ��ʹ�õĵȺ��жϣ���֪�Ƿ�������ֵ�������
                                                     % �������Ը���  
eps = 1e-8;
isc = any( arrayfun( @(x) abs(x-hc)<=eps , hc_list ) );                                      
