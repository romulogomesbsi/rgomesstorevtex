import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:rgomes_store/core/http_client.dart';
import 'package:rgomes_store/data/datasources/vtex_remote_datasource.dart';
import 'package:rgomes_store/data/models/product_model.dart';

// Mock classes
class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late VtexRemoteDataSource dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = VtexRemoteDataSource(mockHttpClient);
  });

  group('VtexRemoteDataSource', () {
    group('fetchProducts', () {
      final mockProductJson = {
        'productId': '1',
        'productName': 'Test Product',
        'brand': 'Test Brand',
        'description': 'Test Description',
        'categories': ['Category 1'],
        'productTitle': 'Test Product Title',
        'items': [
          {
            'images': [
              {'imageUrl': 'https://example.com/image.jpg'},
            ],
            'sellers': [
              {
                'commertialOffer': {'Price': 99.99},
              },
            ],
          },
        ],
      };

      final expectedProductModel = ProductModel(
        id: '1',
        name: 'Test Product',
        imageUrl: 'https://example.com/image.jpg',
        price: 99.99,
        description: 'Test Description',
        brand: 'Test Brand',
        categories: ['Category 1'],
        productTitle: 'Test Product Title',
      );

      test(
        'should return list of ProductModel when status code is 200',
        () async {
          // Arrange
          final mockResponse = http.Response(
            jsonEncode([mockProductJson]),
            200,
          );
          when(
            () => mockHttpClient.get('catalog_system/pub/products/search'),
          ).thenAnswer((_) async => mockResponse);

          // Act
          final result = await dataSource.fetchProducts();

          // Assert
          expect(result, isA<List<ProductModel>>());
          expect(result.length, 1);
          expect(result.first.id, expectedProductModel.id);
          expect(result.first.name, expectedProductModel.name);
          expect(result.first.imageUrl, expectedProductModel.imageUrl);
          expect(result.first.price, expectedProductModel.price);
          expect(result.first.description, expectedProductModel.description);
          expect(result.first.brand, expectedProductModel.brand);
          expect(result.first.categories, expectedProductModel.categories);
          expect(result.first.productTitle, expectedProductModel.productTitle);
        },
      );

      test(
        'should return list of ProductModel when status code is 206',
        () async {
          // Arrange
          final mockResponse = http.Response(
            jsonEncode([mockProductJson]),
            206,
          );
          when(
            () => mockHttpClient.get('catalog_system/pub/products/search'),
          ).thenAnswer((_) async => mockResponse);

          // Act
          final result = await dataSource.fetchProducts();

          // Assert
          expect(result, isA<List<ProductModel>>());
          expect(result.length, 1);
          verify(
            () => mockHttpClient.get('catalog_system/pub/products/search'),
          ).called(1);
        },
      );

      test(
        'should return empty list when response body is empty array',
        () async {
          // Arrange
          final mockResponse = http.Response(jsonEncode([]), 200);
          when(
            () => mockHttpClient.get('catalog_system/pub/products/search'),
          ).thenAnswer((_) async => mockResponse);

          // Act
          final result = await dataSource.fetchProducts();

          // Assert
          expect(result, isA<List<ProductModel>>());
          expect(result.length, 0);
        },
      );

      test(
        'should handle products with missing or null fields gracefully',
        () async {
          // Arrange
          final incompleteProductJson = {
            'productId': '2',
            'productName': null,
            'items': [],
          };
          final mockResponse = http.Response(
            jsonEncode([incompleteProductJson]),
            200,
          );
          when(
            () => mockHttpClient.get('catalog_system/pub/products/search'),
          ).thenAnswer((_) async => mockResponse);

          // Act
          final result = await dataSource.fetchProducts();

          // Assert
          expect(result, isA<List<ProductModel>>());
          expect(result.length, 1);
          expect(result.first.id, '2');
          expect(result.first.name, '');
          expect(result.first.imageUrl, '');
          expect(result.first.price, 0.0);
          expect(result.first.description, '');
          expect(result.first.brand, '');
          expect(result.first.categories, []);
          expect(result.first.productTitle, '');
        },
      );

      test(
        'should handle products with metaTagDescription when description is null',
        () async {
          // Arrange
          final productWithMetaDescription = {
            'productId': '3',
            'productName': 'Test Product',
            'description': null,
            'metaTagDescription': 'Meta Description',
            'items': [],
          };
          final mockResponse = http.Response(
            jsonEncode([productWithMetaDescription]),
            200,
          );
          when(
            () => mockHttpClient.get('catalog_system/pub/products/search'),
          ).thenAnswer((_) async => mockResponse);

          // Act
          final result = await dataSource.fetchProducts();

          // Assert
          expect(result.first.description, 'Meta Description');
        },
      );

      test('should handle products with malformed price data', () async {
        // Arrange
        final productWithBadPrice = {
          'productId': '4',
          'productName': 'Test Product',
          'items': [
            {
              'sellers': [
                {
                  'commertialOffer': {'Price': 'invalid_price'},
                },
              ],
            },
          ],
        };
        final mockResponse = http.Response(
          jsonEncode([productWithBadPrice]),
          200,
        );
        when(
          () => mockHttpClient.get('catalog_system/pub/products/search'),
        ).thenAnswer((_) async => mockResponse);

        // Act
        final result = await dataSource.fetchProducts();

        // Assert
        expect(result.first.price, 0.0);
      });

      test('should throw Exception when status code is 400', () async {
        // Arrange
        final mockResponse = http.Response('Bad Request', 400);
        when(
          () => mockHttpClient.get('catalog_system/pub/products/search'),
        ).thenAnswer((_) async => mockResponse);

        // Act & Assert
        expect(
          () async => await dataSource.fetchProducts(),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Erro ao buscar produtos VTEX: 400'),
            ),
          ),
        );
      });

      test('should throw Exception when status code is 404', () async {
        // Arrange
        final mockResponse = http.Response('Not Found', 404);
        when(
          () => mockHttpClient.get('catalog_system/pub/products/search'),
        ).thenAnswer((_) async => mockResponse);

        // Act & Assert
        expect(
          () async => await dataSource.fetchProducts(),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Erro ao buscar produtos VTEX: 404'),
            ),
          ),
        );
      });

      test('should throw Exception when status code is 500', () async {
        // Arrange
        final mockResponse = http.Response('Internal Server Error', 500);
        when(
          () => mockHttpClient.get('catalog_system/pub/products/search'),
        ).thenAnswer((_) async => mockResponse);

        // Act & Assert
        expect(
          () async => await dataSource.fetchProducts(),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Erro ao buscar produtos VTEX: 500'),
            ),
          ),
        );
      });

      test('should call HttpClient.get with correct endpoint', () async {
        // Arrange
        final mockResponse = http.Response(jsonEncode([]), 200);
        when(
          () => mockHttpClient.get('catalog_system/pub/products/search'),
        ).thenAnswer((_) async => mockResponse);

        // Act
        await dataSource.fetchProducts();

        // Assert
        verify(
          () => mockHttpClient.get('catalog_system/pub/products/search'),
        ).called(1);
      });

      test('should handle network timeout', () async {
        // Arrange
        when(
          () => mockHttpClient.get('catalog_system/pub/products/search'),
        ).thenThrow(Exception('Network timeout'));

        // Act & Assert
        expect(
          () async => await dataSource.fetchProducts(),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Network timeout'),
            ),
          ),
        );
      });

      test('should handle multiple products correctly', () async {
        // Arrange
        final multipleProductsJson = [
          {
            'productId': '1',
            'productName': 'Product 1',
            'brand': 'Brand 1',
            'items': [
              {
                'images': [
                  {'imageUrl': 'https://example.com/image1.jpg'},
                ],
                'sellers': [
                  {
                    'commertialOffer': {'Price': 10.99},
                  },
                ],
              },
            ],
          },
          {
            'productId': '2',
            'productName': 'Product 2',
            'brand': 'Brand 2',
            'items': [
              {
                'images': [
                  {'imageUrl': 'https://example.com/image2.jpg'},
                ],
                'sellers': [
                  {
                    'commertialOffer': {'Price': 20.99},
                  },
                ],
              },
            ],
          },
        ];
        final mockResponse = http.Response(
          jsonEncode(multipleProductsJson),
          200,
        );
        when(
          () => mockHttpClient.get('catalog_system/pub/products/search'),
        ).thenAnswer((_) async => mockResponse);

        // Act
        final result = await dataSource.fetchProducts();

        // Assert
        expect(result.length, 2);
        expect(result[0].id, '1');
        expect(result[0].name, 'Product 1');
        expect(result[0].price, 10.99);
        expect(result[1].id, '2');
        expect(result[1].name, 'Product 2');
        expect(result[1].price, 20.99);
      });
    });
  });
}
