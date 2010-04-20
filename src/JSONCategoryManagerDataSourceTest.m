#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>
#import "CategoryModels.h"
#import "Category.h"
#import "JSON.h"


@interface JSONCategoryManagerDataSourceTest : SenTestCase {
	CategoryModel *categoryModel;
	id<CategoryManagerDataSource> categoryManager;
}

@end

// --------------------------------------------------------------------------

static NSString *categoryJson = @"[{\"categoryId\":\"1\",\"title\":\"Maso\",\"parent\":\"0\",\"order\":\"0\",\"recipeCount\":\"0\"},{\"categoryId\":\"2\",\"title\":\"Testoviny\",\"parent\":\"0\",\"order\":\"0\",\"recipeCount\":\"0\"},{\"categoryId\":\"3\",\"title\":\"Zdrav\u00e1 j\u00eddla\",\"parent\":\"0\",\"order\":\"0\",\"recipeCount\":\"0\"},{\"categoryId\":\"4\",\"title\":\"Ku\u0159ec\u00ed\",\"parent\":\"1\",\"order\":\"3\",\"recipeCount\":\"2\"},{\"categoryId\":\"5\",\"title\":\"Vep\u0159ov\u00e9\",\"parent\":\"1\",\"order\":\"2\",\"recipeCount\":\"0\"},{\"categoryId\":\"6\",\"title\":\"Hov\u011bz\u00ed\",\"parent\":\"1\",\"order\":\"1\",\"recipeCount\":\"0\"},{\"categoryId\":\"7\",\"title\":\"Kol\u00ednka\",\"parent\":\"2\",\"order\":\"0\",\"recipeCount\":\"1\"},{\"categoryId\":\"8\",\"title\":\"P\u00edsmenka\",\"parent\":\"2\",\"order\":\"0\",\"recipeCount\":\"0\"}]";


@implementation JSONCategoryManagerDataSourceTest

- (void) setUp {
	NSArray *categoriesData = [categoryJson JSONValue];
	STAssertTrue([categoriesData count] == 8, @"");		//there are 8 categories in json

	categoryModel = [[CategoryModel alloc] init];
	
	NSMutableArray *categories = [NSMutableArray array];
	for (NSDictionary *categoryData in categoriesData) {
		[categories addObject:[[[Category alloc] initWithDictionary:categoryData] autorelease]];
	}
	categoryModel.categories = categories;
	
	categoryManager = [[JSONCategoryModel alloc] init];
}

- (void) tearDown {
	TT_RELEASE_SAFELY(categoryModel);
	TT_RELEASE_SAFELY(categoryManager);
}

- (void)testCategoryModelSubcategoriesForCategoryId {
	
	/*
	 * try to get subcategories for node of categoryId 1 (Maso) => it should be categories 
	 * 4 (Kureci), 5 (Veprove) and 6 (Hovezi)
	 */	
	NSArray *keys = [NSArray arrayWithObjects:@"categoryId", @"title", @"parent", @"order", @"recipeCount", nil];
	NSArray *cat4 = [NSArray arrayWithObjects:@"4", @"Kuřecí", @"1", @"3", @"2", nil];
	NSArray *cat5 = [NSArray arrayWithObjects:@"5", @"Vepřové", @"1", @"2", @"0", nil];
	NSArray *cat6 = [NSArray arrayWithObjects:@"6", @"Hovězí", @"1", @"1", @"0", nil];
	
	NSArray *expectedResult = [[NSArray alloc] initWithObjects:
							   [[Category alloc] initWithDictionary:[NSDictionary dictionaryWithObjects:cat4 forKeys:keys]],
							   [[Category alloc] initWithDictionary:[NSDictionary dictionaryWithObjects:cat5 forKeys:keys]],
   							   [[Category alloc] initWithDictionary:[NSDictionary dictionaryWithObjects:cat6 forKeys:keys]],
							   nil];
	
	STAssertEqualObjects([categoryManager categoryModel:categoryModel subcategoriesForCategoryId:@"1"],
						 expectedResult,
						 @"");
	[expectedResult release];
	
}


- (void)testCategoryModelCategoriesForRoot {
	/*
	 * For root there should be 3 categories: 1 (Maso), 2 (Testoviny), 3 (Zdrava jidla)
	 */
	NSArray *keys = [NSArray arrayWithObjects:@"categoryId", @"title", @"parent", @"order", @"recipeCount", nil];
	NSArray *cat4 = [NSArray arrayWithObjects:@"1", @"Maso", @"0", @"0", @"0", nil];
	NSArray *cat5 = [NSArray arrayWithObjects:@"2", @"Testoviny", @"0", @"0", @"0", nil];
	NSArray *cat6 = [NSArray arrayWithObjects:@"3", @"Zdravá jídla", @"0", @"0", @"0", nil];
	
	NSArray *expectedResult = [[NSArray alloc] initWithObjects:
							   [[Category alloc] initWithDictionary:[NSDictionary dictionaryWithObjects:cat4 forKeys:keys]],
							   [[Category alloc] initWithDictionary:[NSDictionary dictionaryWithObjects:cat5 forKeys:keys]],
   							   [[Category alloc] initWithDictionary:[NSDictionary dictionaryWithObjects:cat6 forKeys:keys]],
							   nil];
	
	STAssertEqualObjects([categoryManager categoryModelCategoriesForRoot:categoryModel],
						 expectedResult,
						 @"");
	[expectedResult release];
}


- (void)testCategoryManagerHasSubcategoriesForCategoryId {
	// current category manager has subcategories only for node 1 and 2
	STAssertTrue([categoryManager categoryModel:categoryModel hasSubcategoriesForCategoryId:@"1"], @"");
	STAssertTrue([categoryManager categoryModel:categoryModel hasSubcategoriesForCategoryId:@"2"], @"");
	STAssertFalse([categoryManager categoryModel:categoryModel hasSubcategoriesForCategoryId:@"3"], @"");
	STAssertFalse([categoryManager categoryModel:categoryModel hasSubcategoriesForCategoryId:@"4"], @"");
	STAssertFalse([categoryManager categoryModel:categoryModel hasSubcategoriesForCategoryId:@"5"], @"");
	STAssertFalse([categoryManager categoryModel:categoryModel hasSubcategoriesForCategoryId:@"6"], @"");
	STAssertFalse([categoryManager categoryModel:categoryModel hasSubcategoriesForCategoryId:@"7"], @"");
	STAssertFalse([categoryManager categoryModel:categoryModel hasSubcategoriesForCategoryId:@"8"], @"");
}

- (void)testCategoryModelHasRecipesForCategoryId {
	// in category manager there are only 2 recipes for node 4 and 1 recipe for node 7
	STAssertFalse([categoryManager categoryModel:categoryModel hasRecipesForCategoryId:@"1"], @"");
	STAssertFalse([categoryManager categoryModel:categoryModel hasRecipesForCategoryId:@"2"], @"");
	STAssertFalse([categoryManager categoryModel:categoryModel hasRecipesForCategoryId:@"3"], @"");
	STAssertTrue([categoryManager categoryModel:categoryModel hasRecipesForCategoryId:@"4"], @"");
	STAssertFalse([categoryManager categoryModel:categoryModel hasRecipesForCategoryId:@"5"], @"");
	STAssertFalse([categoryManager categoryModel:categoryModel hasRecipesForCategoryId:@"6"], @"");
	STAssertTrue([categoryManager categoryModel:categoryModel hasRecipesForCategoryId:@"7"], @"");
	STAssertFalse([categoryManager categoryModel:categoryModel hasRecipesForCategoryId:@"8"], @"");	
}


@end
